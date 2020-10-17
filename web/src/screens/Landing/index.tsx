import React from 'react';
import {Link} from 'react-router-dom';
import {FiArrowRight} from 'react-icons/fi';

import logoImg from '../../images/logo.svg';

import './styles.css';

export default function Landing() {
  return (
    <div id="page-landing">
      <div className="content-wrapper">
        <img src={logoImg} alt="Logo"/>

        <main>
          <h1>Leve felicidade para o mundo</h1>
          <p>Visite orfanatos e mude o dia de muitas crianças</p>
        </main>

        <div className="location">
          <strong>Itabira</strong>
          <span>Minas Gerais</span>
        </div>

        <Link to="/app" className="enter-app">
          <FiArrowRight color="rgba(0, 0, 0, 0.6)" size={26} />
        </Link>
      </div>
    </div>
  );
}