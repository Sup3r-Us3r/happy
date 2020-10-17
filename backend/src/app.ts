import express from 'express';
import cors from 'cors';
import {resolve} from 'path';

import routes from './routes';

import errorHandler from './errors/handler';

class App {
  public server = express();

  constructor() {
    this.middlewares();
  }

  middlewares() {
    this.server.use(express.urlencoded({ extended: false }));
    this.server.use(express.json());
    this.server.use(cors());
    this.server.use(routes);
    this.server.use(
      '/uploads',
      express.static(resolve(__dirname, '..', 'uploads')
      ));
    this.server.use(errorHandler);
  }
}

export default new App().server;
