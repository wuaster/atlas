# CarbonCash (2020 IBM NA Intern Hackathon - Team ATLAS)

CarbonCash is an app that aims to encourage people to choose more eco-friendly transportation methods by calculating the money they could save by not driving. In addition, CarbonCash is also capable of determining your ecological footprint in the form of CO2 emissions produced while driving.

With the money that is saved by choosing not to drive, it is our goal that users will donate all or some of it to charity. To make this step seamless for users, CarbonCash provides direct links to some of our favourite charitable organizations including TreeCanada, Arbor Day Foundation, and Water.org.

CarbonCash uses Watson Assistant as the main interface. Through Assistant, users can calculate their trip costs, display their savings, track their carbon footprint, and find charitable organizations to donate to. To improve user experience, CarbonCash also provides a dashboard interface where users can immediately view their daily, weekly, monthly, and yearly cash and CO2 savings.

## The Problem
It’s no secret--earth’s average surface temperature is rising as a direct result of human activity. Due to the large-scale nature of the issue, it often feels like the changes we make in our life will have little to no impact on the overall problem. This is the focus of CarbonCash. If everyone made a small lifestyle change--like riding your bike to work a few times a week--we could make a huge difference (and save some money, too).

## The Solution
Since the causes of climate change happen on such a large scale, it’s easy to believe that your lifestyle has no impact on climate change. To solve this problem, CarbonCash evaluates your environmental impact in an easily quantifiable metric: money. This helps users feel like they’re making a real impact, while also encouraging them to expand upon that by donating transportation savings to reputable and relevant charities.

## Tech

CarbonCash is built using:

- Flutter
- Express
- Watson Assistant

## Next Steps

- Add payment processing in-app so users can simply ask the CarbonCash chatbot “Please donate my savings to X” or “donate 50% of my savings on this trip”

- Allow users to specify the mode of transportation (bike, carpool etc..) as well as gas milage, price per liter.

- Add a feature to record your trips in real time and provide some award to verify your impact and make it more meaningful. Could even add these real time trips to blockchain and possibly even award “carbon crypto” for these verified trips.

- Make Watson even smarter and be able to plan trips for optimal emissions.

- Enable watson to recommend charities based on user preferences and trip geography.

# Development


## App
Make sure you have [Flutter](https://flutter.dev/docs/get-started/install/macos) installed (we used `1.17`) as well as XCode from the Mac App Store.

Ensure the `API_BASE` in `globals.dart` points to your backend server.

Don't forget to run `flutter pub get`

Following the guide above should get you up and running.


## Backend
To run the backend server:
- Navigate to the backend directory:
```bash
cd backend
```
- Create a `.env` file based on the `.env.example`
```bash
touch .env && cat .env.example > .env
```
Install dependencies:
```bash
npm install
```
Run in development (default port 3000, but you can specify in your `.env` file)
```bash
npm run dev
```
Or run in production (NOTE: `.env` variables will not be loaded)
```bash
npm start
```
## Env variables
```
PORT=
WATSON_VERSION=
WATSON_API_KEY=
WATSON_URL=
WATSON_ASSISTANT_ID=
HERE_API_KEY=
HERE_GEOCODE_ENDPOINT=
HERE_ROUTES_ENDPOINT=
```
