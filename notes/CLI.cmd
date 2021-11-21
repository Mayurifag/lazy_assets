# CLI notes

## Frontend

### Repository creation

```sh
npx expo-cli init lazy_assets_frontend
cd lazy_assets_frontend
yarn run start

###
npm install -g sharp-cli
```

### Webpack analyze

<https://docs.expo.dev/guides/web-performance/>

### Codegen

```sh
cd backend
bundle exec rails graphql:dump_schema
cd ../frontend
npx apollo codegen:generate --localSchemaFile=schema.json --target=typescript --tagName=gql
```
