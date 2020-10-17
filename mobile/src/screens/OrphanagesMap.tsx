import React, {useState} from 'react';
import {View, Text, StyleSheet, Dimensions} from 'react-native';
import {useFocusEffect, useNavigation} from '@react-navigation/native';
import {RectButton} from 'react-native-gesture-handler';
import MapView, {Marker, Callout, PROVIDER_GOOGLE} from 'react-native-maps';
import {Feather} from '@expo/vector-icons';

import api from '../services/api';

import mapMarker from '../images/map-marker.png';

interface IOrphanage {
  id: number;
  name: string;
  latitude: number;
  longitude: number;
}

const OrphanagesMap = () => {
  const navigation = useNavigation();

  const [orphanages, setOrphanages] = useState<IOrphanage[]>([]);

  function handleNavigateToOrphanageDetails(id: number) {
    navigation.navigate('OrphanagesDetails', {id});
  }

  useFocusEffect(() => {
    api.get('/orphanages').then(response => {
      setOrphanages(response.data);
    });
  });

  return (
    <View style={styles.container}>
      <MapView
        style={styles.map}
        provider={PROVIDER_GOOGLE}
        initialRegion={{
          latitude: -19.6596133,
          longitude: -43.2315159,
          latitudeDelta: 0.008,
          longitudeDelta: 0.008,
        }}
      >
        {orphanages.map(orphanage => (
          <Marker
            key={orphanage.id}
            calloutAnchor={{
              x: 2.7,
              y: 0.9,
            }}
            icon={mapMarker}
            coordinate={{
              latitude: orphanage.latitude,
              longitude: orphanage.longitude,
            }}
          >
            <Callout
              tooltip
              onPress={() => handleNavigateToOrphanageDetails(orphanage.id)}
              style={styles.calloutContainer}
            >
              <View>
                <Text style={styles.calloutText}>{orphanage.name}</Text>
              </View>
            </Callout>
          </Marker>
        ))}
      </MapView>

      <View style={styles.footer}>
        <Text style={styles.footerText}>{orphanages.length} Orphanages found</Text>

        <RectButton
          style={styles.createOrphanageButton}
          onPress={() => navigation.navigate('SelectMapPosition')}
        >
          <Feather name="plus" size={28} color="#FFF" />
        </RectButton>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },

  map: {
    height: Dimensions.get('screen').height,
    width: Dimensions.get('screen').width,
  },

  calloutContainer: {
    height: 60,
    width: 60,
    paddingHorizontal: 16,
    backgroundColor: 'rgba(255, 255, 255, 0.8)',
    borderRadius: 16,
    justifyContent: 'center',
  },

  calloutText: {
    color: '#0089a5',
    fontSize: 14,
  },

  footer: {
    position: 'absolute',
    left: 24,
    right: 24,
    bottom: 32,
    backgroundColor: '#FFF',
    borderRadius: 20,
    height: 56,
    paddingLeft: 24,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    elevation: 30,
  },

  footerText: {
    color: '#8fa7b3',
  },

  createOrphanageButton: {
    height: 56,
    width: 56,
    backgroundColor: '#15c3d6',
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

export default OrphanagesMap;