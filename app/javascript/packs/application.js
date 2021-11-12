require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("particles.js")

// External imports
import "bootstrap";
import 'glightbox';

import { initAos } from '../components/aos';
import { greatListener } from '../components/filter_listener';
import { initPureCounter } from '../components/pure_counter';
import { initValidate } from '../components/validate';
import { initWtf } from '../components/what_is_this';
import { initAmCharts } from './amcharts';

document.addEventListener('turbolinks:load', () => {
  initAos()
  greatListener()
  initPureCounter()
  initValidate()
  initWtf()
  initAmCharts()
});

