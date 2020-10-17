import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createStackNavigator} from '@react-navigation/stack';

import Header from './components/Header';

import OrphanagesMap from './screens/OrphanagesMap';
import OrphanagesDetails from './screens/OrphanagesDetails';
import SelectMapPosition from './screens/CreateOrphanages/SelectMapPosition';
import OrphanageData from './screens/CreateOrphanages/OrphanageData';

const Routes = () => {
  const Stack = createStackNavigator();

  return (
    <NavigationContainer>
      <Stack.Navigator screenOptions={{
        headerShown: false,
        cardStyle: {
          backgroundColor: '#f2f3f5',
        }
      }}>
        <Stack.Screen name="OrphanagesMap" component={OrphanagesMap} />
        <Stack.Screen
          name="OrphanagesDetails"
          component={OrphanagesDetails}
          options={{
            headerShown: true,
            header: () => <Header title="Orfanato" showCancel={false} />
          }}
        />
        <Stack.Screen
          name="SelectMapPosition"
          component={SelectMapPosition}
          options={{
            headerShown: true,
            header: () => <Header title="Selecione no mapa" />
          }}
        />
        <Stack.Screen
          name="OrphanageData"
          component={OrphanageData}
          options={{
            headerShown: true,
            header: () => <Header title="Informe os dados" />
          }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default Routes;
