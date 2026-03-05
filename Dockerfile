# FROM node:20-alpine

# USER node

# WORKDIR /home/node/code

# COPY --chown=node:node package*.json ./ 

# RUN npm ci

# COPY --chown=node . .

# CMD [ "node", "index.js" ]

###############################################################################

FROM alpine:3.19

RUN apk add --update nodejs npm 
# Alpine does not include anything, so we use apk (the package manager) to install node and npm

RUN addgroup -S node && adduser -S node -G node
# We create the node group and the node user, since the alpine container does not contain them

USER node

WORKDIR /home/node/code

COPY --chown=node:node package*.json ./ 

RUN npm ci

COPY --chown=node . .

CMD [ "node", "index.js" ]