# atlas

Built using:

- Flutter
- Express
- Watson Assistant

We want to allow users the option to offset their carbon emissions by donating money saved to charities like: TreeCanada, Arbor Day Foundation, Charity: Water. For the purpose of the hackathon, we are focusing on carbon emissions that were theoretically generated during travel. There is going to be a chatbot that asks you what kind of commute. Itll branch off into other questions. At the end, you will see a number of co2 emissions you saved and how much money you can give back to offset

# Features

- Chatbot manual trip input
- Record your trip
- Blockchain leaderboard/stats aggregation
- Links to relevant organizations to donate to

# Development

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