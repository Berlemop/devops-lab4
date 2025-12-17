// app.test.js
const request = require('supertest');
const app = require('./app');

describe('Test the root path', () => {
  test('It should respond to the GET method', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Hello, World!');
  });
});

describe('Test the /name/:name path', () => {
  test('It should respond with a personalized greeting', async () => {
    const name = 'Alice';
    const response = await request(app).get(`/name/${name}`);
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe(`Hello, ${name}!`);
  });
});

// EX9
describe('Test the /add/:a/:b path', () => {
  test('sum of two integers', async () => {
    const response = await request(app).get('/add/5/3');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('8');
  });

  test('sum of two floats', async () => {
    const response = await request(app).get('/add/2.5/3.5');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('6');
  });

  test('invalid input (letters)', async () => {
    const response = await request(app).get('/add/abc/3');
    expect(response.statusCode).toBe(400);
    expect(response.text).toBe('Invalid numbers');
  });
});