/**
 * Creates an HTTP server that listens on port 3000
 * @param {http.IncomingMessage} request - The incoming HTTP request object
 * @param {http.ServerResponse} response - The outgoing HTTP response object
 * @returns {http.Server} The HTTP server instance listening on port 3000
 * 
 * @description
 * Sets up a basic HTTP server that:
 * - Logs "request received" to the console when a request is made
 * - Responds to all requests with the text "omg hi"
 * - Listens on localhost:3000
 * - Logs "server started" when the server initializes
 */

// Example 1:
// const http = require("http");

// http
//   .createServer(function (request, response) {
//     console.log("request received");
//     response.end("omg hi", "utf-8");
//   })
//   .listen(3000);
// console.log("server started");

// ------------------------------------------------------ //

// Example 2:
const fastify = require("fastify")({ logger: true });

// Declare a route
fastify.get("/", function handler(request, reply) {
  reply.send({ hello: "world" });
});

// Run the server!
fastify.listen({ port: 8080, host: "0.0.0.0" }, (err) => {
  if (err) {
    fastify.log.error(err);
    process.exit(1);
  }
});