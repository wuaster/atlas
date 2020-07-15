if (process.env.NODE_ENV !== "production") {
  require("dotenv").config();
}
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
const port = process.env.PORT || 3000;
const watsonCreds = {
  version: process.env.WATSON_VERSION || "",
  apiKey: process.env.WATSON_API_KEY || "",
  url: process.env.WATSON_URL || "",
  id: process.env.WATSON_ASSISTANT_ID || "",
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

app.post("/message", async (req, res) => {
  const msgObj = req.body;
  if (!msgObj.sessionId) return res.send("Invalid 'sessionId' field.");
  if (!msgObj.text) return res.send("Invalid 'text' field.");
  if (!msgObj.user) return res.send("Invalid 'user' field.");
  if (!msgObj.date) return res.send("Invalid 'date' field.");

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

app.get("*", (_req, res) => {
  res.send("Invalid route or method.");
});

// Start server
app.listen(port, (err) => {
  if (err) throw err;
  console.log(`server listening at port ${port}`);
});
