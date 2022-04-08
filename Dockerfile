# pull official base image
FROM node:16-alpine AS prod

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

ENV NODE_ENV $NODE_ENV
ENV PORT $PORT

# install app dependencies
COPY package*.json ./
RUN npm install --silent
RUN npm ci --silent
RUN npm install react-scripts@3.4.1 -g --silent
# add app
COPY . ./

RUN npm run build
RUN npm install -g serve

EXPOSE $PORT

CMD serve -s build
