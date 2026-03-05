# FROM node:20-alpine

# USER node

# WORKDIR /home/node/code

# COPY --chown=node:node package*.json ./ 

# RUN npm ci

# COPY --chown=node . .

# CMD [ "node", "index.js" ]

###############################################################################
# Reducing container size
###############################################################################

# FROM alpine:3.19

# RUN apk add --update nodejs npm 
# # Alpine does not include anything, so we use apk (the package manager) to install node and npm

# RUN addgroup -S node && adduser -S node -G node
# # We create the node group and the node user, since the alpine container does not contain them

# USER node

# WORKDIR /home/node/code

# COPY --chown=node:node package*.json ./ 

# RUN npm ci

# COPY --chown=node . .

# CMD [ "node", "index.js" ]


##############################################################
# Multi-stage builds
##############################################################

# build step
# FROM node:20 AS node-builder
# RUN mkdir /build
# WORKDIR /build
# COPY package*.json ./
# RUN npm ci
# COPY . .

# production step
# FROM alpine:3.19
# RUN apk add --update nodejs 
# RUN addgroup -S node && adduser -S node -G node
# USER node
# RUN mkdir /home/node/code
# WORKDIR /home/node/code
# COPY --from=node-builder --chown=node:node /build .
# CMD [ "node", "index.js" ]

##############################################################
# Distroless
##############################################################

# build stage
FROM node:20 AS node-builder
WORKDIR /build
COPY package-lock.json package.json ./
RUN npm ci
COPY . .

# runtime stage
FROM gcr.io/distroless/nodejs20
COPY --from=node-builder --chown=node:node /build /app
WORKDIR /app
CMD ["index.js"]