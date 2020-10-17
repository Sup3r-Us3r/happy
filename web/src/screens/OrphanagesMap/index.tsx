import React, {useState, useEffect} from 'react';
import {Link} from 'react-router-dom';
import {FiPlus, FiArrowRight} from 'react-icons/fi';
import {Map, TileLayer, Marker, Popup} from 'react-leaflet'

import api from '../../services/api';

import mapMarkerImg from '../../images/map-marker.svg';
import mapIcon from '../../utils/mapIcon';

import './styles.css';

interface IOrphanages {
  id: number;
  latitude: number;
  longitude: number;
  name: string;
}

export default function OrphanagesMap() {
  const [orphanages, setOrphanages] = useState<IOrphanages[]>([]);

  useEffect(() => {
    async function handleOrphanages() {
      const response = await api.get('/orphanages');

      setOrphanages(response.data);
    }

    handleOrphanages();
  }, []);

  return (
    <div id="page-map">
      <aside>
        <header>
          <img src={mapMarkerImg} alt="Map Marker"/>

          <h2>Ecolha um orfanato no mapa</h2>
          <p>Muitas crianças estão esperando a sua visita</p>
        </header>

        <footer>
          <strong>Itabira</strong>
          <span>Minas Gerais</span>
        </footer>
      </aside>

      <Map center={[-19.635304, -43.2328578]} zoom={15} style={{
        height: '100%',
        width: '100%',
      }}>
        {/* <TileLayer url="https://a.tile.openstreetmap.org/{z}/{x}/{y}.png" /> */}
        <TileLayer
          url={`https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/256/{z}/{x}/{y}@2x?access_token=${process.env.REACT_APP_MAPBOX_TOKEN}`}
        />

        {orphanages.map(orphanage => (
          <Marker
            key={orphanage.id}
            position={[orphanage.latitude, orphanage.longitude]}
            icon={mapIcon}
          >
            <Popup
              closeButton={false}
              minWidth={240}
              maxWidth={240}
              className="map-popup"
            >
              {orphanage.name}
              <Link to={`/orphanages/${orphanage.id}`}>
                <FiArrowRight color="#FFF" size={20} />
              </Link>
            </Popup>
          </Marker>
        ))}
      </Map>

      <Link to="/orphanages/create" className="create-orphanage">
        <FiPlus color="#FFF" size={32} />
      </Link>
    </div>
  );
}
