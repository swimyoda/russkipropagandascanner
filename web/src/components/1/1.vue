<template src="./details.html"></template>
<style src="./details.scss" lang="scss"></style>
<script>
export default {
  name: 'details',
  data() {
    let data = [
      {
        name: 'Russian Propaganda #1',
        id: 1,
      },
      {
        name: 'Russian Propaganda #2',
        id: 2,
      },
      {
        name: 'Russian Propaganda #3',
        id: 3,
      },
      {
        name: 'Russian Propaganda #3',
        id: 4,
      },
      {
        name: 'Russian Propaganda #3',
        id: 5,
      },
      {
        name: 'Russian Propaganda #3',
        id: 6,
      },
      {
        name: 'Russian Propaganda #3',
        id: 7,
      },
      {
        name: 'Russian Propaganda #3',
        id: 8,
      },
      {
        name: 'Russian Propaganda #3',
        id: 9,
      },
    ];

    return {
      entries: data,
      entry: data[this.$route.params.id - 1],
    };
  },
};
</script>
