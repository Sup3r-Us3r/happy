import React, {useState, FormEvent, ChangeEvent} from "react";
import {useHistory} from "react-router-dom";
import {Map, Marker, TileLayer} from 'react-leaflet';
import {LeafletMouseEvent} from 'leaflet';
import {FiPlus} from "react-icons/fi";

import api from '../../services/api';

import Sidebar from "../../components/Sidebar";
import mapIcon from "../../utils/mapIcon";

import './styles.css';

export default function CreateOrphanage() {
  const history = useHistory();

  const [position, setPosition] = useState({ latitude: 0, longitude: 0 });
  const [name, setName] = useState<string>('');
  const [about, setAbout] = useState<string>('');
  const [instructions, setInstructions] = useState<string>('');
  const [opening_hours, setOpeningHours] = useState<string>('');
  const [open_on_weekends, setOpenOnWeekends] = useState<boolean>(true);
  const [images, setImages] = useState<File[]>([]);
  const [previewImages, setPreviewImages] = useState<string[]>();

  function handleMapClick(event: LeafletMouseEvent) {
    const {lat, lng} = event.latlng;

    setPosition({
      latitude: lat,
      longitude: lng,
    });
  }

  function handleSelectImages(event: ChangeEvent<HTMLInputElement>) {
    if (!event.target.files) {
      return;
    }

    const selectedImages = Array.from(event.target.files);

    setImages(selectedImages);

    const selectedImagesPreview = selectedImages.map(image => {
      return URL.createObjectURL(image);
    });

    setPreviewImages(selectedImagesPreview);
  }

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();

    const {latitude, longitude} = position;

    const data = new FormData();

    data.append('name', name);
    data.append('about', about);
    data.append('latitude', String(latitude));
    data.append('longitude', String(longitude));
    data.append('instructions', instructions);
    data.append('opening_hours', opening_hours);
    data.append('open_on_weekends', String(open_on_weekends));

    images.forEach(image => data.append('images', image));

    await api.post('/orphanages', data);

    alert('Cadastro realizado com sucesso!');

    history.push('/app');
  }

  return (
    <div id="page-create-orphanage">
      <Sidebar />

      <main>
        <form className="create-orphanage-form" onSubmit={handleSubmit}>
          <fieldset>
            <legend>Dados</legend>

            <Map 
              center={[-19.635304, -43.2328578]} 
              style={{ width: '100%', height: 280 }}
              zoom={15}
              onclick={handleMapClick}
            >
              <TileLayer 
                url={`https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/256/{z}/{x}/{y}@2x?access_token=${process.env.REACT_APP_MAPBOX_TOKEN}`}
              />

                {position.latitude !== 0 && (
                  <Marker
                    interactive={false}
                    icon={mapIcon}
                    position={[position.latitude, position.longitude]}
                  />
                )}
            </Map>

            <div className="input-block">
              <label htmlFor="name">Nome</label>
              <input
                id="name"
                onChange={e => setName(e.target.value)}
                value={name}
              />
            </div>

            <div className="input-block">
              <label htmlFor="about">Sobre <span>Máximo de 300 caracteres</span></label>
              <textarea
                id="name"
                maxLength={300}
                onChange={e => setAbout(e.target.value)}
                value={about}
              />
            </div>

            <div className="input-block">
              <label htmlFor="images">Fotos</label>

              <div className="images-container">
                {previewImages?.map(image => (
                  <img key={image} src={image} alt={name} />
                ))}

                <label className="new-image" htmlFor="image[]">
                  <FiPlus size={24} color="#15b6d6" />
                </label>
              </div>

              <input
                id="image[]"
                type="file"
                multiple
                onChange={handleSelectImages}
              />
            </div>
          </fieldset>

          <fieldset>
            <legend>Visitação</legend>

            <div className="input-block">
              <label htmlFor="instructions">Instruções</label>
              <textarea
                id="instructions"
                onChange={e => setInstructions(e.target.value)}
                value={instructions}
              />
            </div>

            <div className="input-block">
              <label htmlFor="opening_hours">Horário de funcionamentos</label>
              <input
                id="opening_hours"
                onChange={e => setOpeningHours(e.target.value)}
                value={opening_hours}
              />
            </div>

            <div className="input-block">
              <label htmlFor="open_on_weekends">Atende fim de semana</label>

              <div className="button-select">
                <button
                  type="button"
                  className={open_on_weekends ? 'active': ''}
                  onClick={() => setOpenOnWeekends(true)}
                >
                  Sim
                </button>
                <button
                  type="button"
                  className={!open_on_weekends ? 'active': ''}
                  onClick={() => setOpenOnWeekends(false)}
                >
                  Não
                </button>
              </div>
            </div>
          </fieldset>

          <button className="confirm-button" type="submit">
            Confirmar
          </button>
        </form>
      </main>
    </div>
  );
}

// return `https://a.tile.openstreetmap.org/${z}/${x}/${y}.png`;
