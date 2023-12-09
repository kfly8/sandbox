import { parse } from 'graphql';

const query = 'type Query { hello: String }';

const result = parse(query);
console.log(JSON.stringify(result));

