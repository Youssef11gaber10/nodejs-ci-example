FROM node:js
COPY nodeapp /nodeapp
WORKDIR /nodeapp
RUN npm install
CMD ["node", "/nodeapp/app.js"]