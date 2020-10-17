import React from 'react';
import {BrowserRouter, Switch, Route} from 'react-router-dom';

import Landing from './screens/Landing';
import OrphanagesMap from './screens/OrphanagesMap';
import CreateOrphanage from './screens/CreateOrphanage';
import Orphanage from './screens/Orphanage';

function Routes() {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" exact component={Landing} />
        <Route path="/app" component={OrphanagesMap} />
        <Route path="/orphanages/create" component={CreateOrphanage} />
        <Route path="/orphanages/:id" component={Orphanage} />
      </Switch>
    </BrowserRouter>
  );
}

export default Routes;