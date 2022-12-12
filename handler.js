'use strict';
// const axios = require('axios');
// const uuid = require('uuid');
// const fakeName = require('test-core/fake-name');

module.exports.hello = async (event) => {
  // const post = await axios.get('https://jsonplaceholder.typicode.com/todos/1')
  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: 'Go Serverless v1.0! Your function executed successfully!',
        // post: post.data,
        // uuid: uuid.v4(),
        // fakeName: fakeName,
        SENDER_MAIL: process.env.SENDER_MAIL,
        APP_URL: process.env.APP_URL,
        USER_POOL_ID: process.env.USER_POOL_ID,
        USER_POOL_CLIENT_ID: process.env.USER_POOL_CLIENT_ID,
      },
      null,
      2
    ),
  };

  // Use this code if you don't use the http event with the LAMBDA-PROXY integration
  // return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
};
