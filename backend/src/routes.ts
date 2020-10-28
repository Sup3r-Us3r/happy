import { Router } from 'express';

import OrphanageController from './controllers/OrphanagesController';

import multerConfig from './config/multer';

const routes = Router();

routes.get('/orphanages', OrphanageController.index);
routes.get('/orphanages/:id', OrphanageController.show);
routes.post(
  '/orphanages',
  multerConfig.array('images[]'),
  OrphanageController.create
);

export default routes;
