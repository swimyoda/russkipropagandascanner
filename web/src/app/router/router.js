import Home from '@/components/home/home';
import Details from '@/components/details/details';

import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/details',
      name: 'details',
      component: Details,
    },
    {
      path: '/details/:id',
      name: 'detailsEntry',
      component: Details,
    },
  ],
});
