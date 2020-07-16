if (process.env.NODE_ENV !== "production") {
  require("dotenv").config();
}
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const { default: Axios } = require("axios");

const app = express();
const port = process.env.PORT || 3000;
const debug = process.env.NODE_ENV === "production";
const watsonCreds = {
  version: process.env.WATSON_VERSION || "",
  apiKey: process.env.WATSON_API_KEY || "",
  url: process.env.WATSON_URL || "",
  id: process.env.WATSON_ASSISTANT_ID || "",
};

const hereCreds = {
  apiKey: process.env.HERE_API_KEY || "",
  geocodingUrl: process.env.HERE_GEOCODE_ENDPOINT || "",
  routesUrl: process.env.HERE_ROUTES_ENDPOINT || "",
};

const watson_err_message =
  "Your message could not be sent at this time. Please try again or contact support.";

function handleError(err) {
  if (err.message && err.status) return `${err.status}: ${err.message}`;
  if (err.message) return err.message;
  return JSON.stringify(err, null, 2);
}

const AssistantV2 = require("ibm-watson/assistant/v2");
const { IamAuthenticator } = require("ibm-watson/auth");

const assistant = new AssistantV2({
  version: watsonCreds.version,
  authenticator: new IamAuthenticator({
    apikey: watsonCreds.apiKey,
  }),
  url: watsonCreds.url,
});

app.use(cors());

// Configuring body parser middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get("/", (_req, res) => {
  res.send("Welcome to the app.");
});

// create a session id to be used for the duration of the session
app.get("/session", async (_req, res) => {
  var result = "";
  try {
    const watsonResponse = await assistant.createSession({
      assistantId: watsonCreds.id,
    });
    if (watsonResponse.result) {
      result = watsonResponse.result.session_id;
    } else {
      result = "Couldn't get a service Id.";
    }
  } catch (err) {
    result = handleError(err);
  } finally {
    res.send(result);
  }
});

// post a message and recieve a response from watson
app.post("/message", async (req, res) => {
  const msgObj = req.body;
  if (!msgObj.sessionId) return res.send("Invalid 'sessionId' field.");
  if (!msgObj.text) return res.send("Invalid 'text' field.");
  if (!msgObj.user) return res.send("Invalid 'user' field.");
  if (!msgObj.date) return res.send("Invalid 'date' field.");
  console.log({ msgObj });
  var result = "";
  // STATEFUL
  try {
    const watsonResponse = await assistant.message({
      assistantId: watsonCreds.id,
      sessionId: msgObj.sessionId,
      input: {
        message_type: "text",
        text: msgObj.text,
      },
    });
    if (!watsonResponse.result) return res.send(watson_err_message);
    if (!watsonResponse.result.output.generic)
      return res.send(watson_err_message);
    result = watsonResponse.result.output.generic[0].text;
  } catch (err) {
    result = handleError(err);
  } finally {
    return res.send(result);
  }
});

async function getCoordinatesFromAddress(address = "") {
  var result = "Sorry, your start address or destination address is invalid.";
  var errorFlag = false;
  try {
    const geocoded = await Axios({
      method: "get",
      url: hereCreds.geocodingUrl,
      params: {
        q: address,
        apiKey: hereCreds.apiKey,
      },
    });
    if (!geocoded.data)
      return {
        error: true,
        result: result,
      };
    if (!geocoded.data.items)
      return {
        error: true,
        result: result,
      };
    if (!geocoded.data.items[0].position)
      return {
        error: true,
        result: result,
      };
    result = geocoded.data.items[0].position;
  } catch (err) {
    if (debug) {
      result = handleError(err);
    }
    errorFlag = true;
  } finally {
    return {
      error: errorFlag,
      result: result,
    };
  }
}

async function getRouteDurationAndLength(origin, dest) {
  // 'origin' and 'dest' are of the format:
  // 56.400,40.4014
  var result = "Sorry, your start address or destination address is invalid.";
  var errorFlag = false;
  try {
    const route = await Axios({
      method: "get",
      url: hereCreds.routesUrl,
      params: {
        transportMode: "car",
        origin: origin,
        destination: dest,
        return: "summary",
        apiKey: hereCreds.apiKey,
      },
    });
    if (!route.data)
      return {
        error: true,
        result: result,
      };
    if (!route.data.routes)
      return {
        error: true,
        result: result,
      };
    if (!route.data.routes[0].sections)
      return {
        error: true,
        result: result,
      };
    if (!route.data.routes[0].sections[0].summary)
      return {
        error: true,
        result: result,
      };
    result = route.data.routes[0].sections[0].summary;
  } catch (err) {
    if (debug) {
      result = handleError(err);
    }
    errorFlag = true;
  } finally {
    return {
      error: errorFlag,
      result: result,
    };
  }
}

async function getEconomyFromDestination(start_address, end_address) {
  console.log(`Getting economy from ${start_address} to ${end_address}...`);

  const originCoordinatesObj = await getCoordinatesFromAddress(start_address);
  if (originCoordinatesObj.error) return routeObj.result;
  const originCoordinates = `${originCoordinatesObj.result.lat},${originCoordinatesObj.result.lng}`;
  // first translate address to coordinates
  const destCoordinatesObj = await getCoordinatesFromAddress(end_address);
  if (destCoordinatesObj.error) return routeObj.result;
  const destCoordinates = `${destCoordinatesObj.result.lat},${destCoordinatesObj.result.lng}`;
  // then get the route
  const routeObj = await getRouteDurationAndLength(
    originCoordinates,
    destCoordinates
  );
  // check for error
  if (routeObj.error) return routeObj.result;

  const routeDuration = routeObj.result.duration;
  const routeLength = routeObj.result.length;

  // finally, calculate economy
  const gasMilage = 11.0 / 100.0; // liters/100 km
  const gasPricePerLiter = 0.9; // in dollars
  const lengthInKm = routeLength / 1000.0;
  const totalDollars = gasMilage * lengthInKm * gasPricePerLiter;
  const roundedTotal = Math.round((totalDollars + Number.EPSILON) * 100) / 100;
  const fuelBurned = lengthInKm * 2.4;
  // return `Cost: ${roundedTotal} CAD. Distance traveled: ${Math.round((lengthInKm + Number.EPSILON) * 100) / 100}km`;
  return {
    dollars: roundedTotal,
    distance: lengthInKm,
    efficiency: gasMilage,
    price: gasPricePerLiter,
    emission: fuelBurned,
  };
}

// endpoint called by the watson assistant via webhooks
app.post("/watson", async (req, res) => {
  const params = req.body;

  if (params.start_address && params.end_address) {
    const response = await getEconomyFromDestination(
      params.start_address,
      params.end_address
    );

    return res.send({ message: response });
  }

  return res.send("nothing");
});

app.get("*", (_req, res) => {
  res.send("Invalid route or method.");
});

// Start server
app.listen(port, (err) => {
  if (err) throw err;
  console.log(`server listening at port ${port}`);
});
