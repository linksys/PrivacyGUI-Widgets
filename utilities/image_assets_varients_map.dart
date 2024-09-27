///
/// Use to generate image data file
/// struct -
/// 'filename' : {
///   'method' : 'filter'|'file',
///   'dark' : 'hex argb color map {'#ff222222': '#ffffffff'} | 'replaced filename',
///   'light' : 'hex argb color map {'#ff222222': '#ffffffff'} | 'replaced filename',
/// }
/// method field is required
/// dark/light can only declare either one of them
///
const imageVarientsMap = <String, dynamic>{
  'linksys_logo_black.svg': {
    'method': 'filter',
    'dark': {'#ff000000': '#ffffffff'}
  },
  'linksys_wordmark.svg': {
    'method': 'filter',
    'light': {'#ffffffff': '#ff000000'}
  },
  'img_add_nodes.svg': {
    'method': 'filter',
    'dark': {'#ff231F20': '#fff3f3f3', '#ff000000': '#ffffffff'}
  },
  'img_move_nodes.svg': {
    'method': 'filter',
    'dark': {'#ff000000': '#ffffffff'}
  },
  'internet_to_router.svg': {
    'method': 'filter',
    'dark': {'#FFD9D9D9': '#ffffffff', '#FF44474F': '#ffffffff'}
  },
  'internet_to_device.svg': {
    'method': 'filter',
    'dark': {'#FFD9D9D9': '#ffffffff', '#FF44474F': '#ffffffff'}
  },
  'img_port_on.svg': {
    'method': 'filter',
    'dark': {'#ff74777f': '#ff008a2d'},
    'light': {'#ff74777f': '#ff008a2d'}
  },
  'node_light_solid_blue.svg': {
    'method': 'filter',
    'dark': {'#ff1a1c1e': '#ffaeaeae'}
  },
  'node_light_blink_blue.svg': {
    'method': 'filter',
    'dark': {'#ff1a1c1e': '#ffaeaeae'}
  },
  'node_light_solid_white.svg': {
    'method': 'filter',
    'dark': {'#ff1a1c1e': '#ffaeaeae'}
  },
  'node_light_blink_white.svg': {
    'method': 'filter',
    'dark': {'#ff1a1c1e': '#ffaeaeae'}
  },
  'node_light_solid_red.svg': {
    'method': 'filter',
    'dark': {'#ff1a1c1e': '#ffaeaeae'}
  },
  'node_light_blink_red.svg': {
    'method': 'filter',
    'dark': {'#ff1a1c1e': '#ffaeaeae'}
  },
  'node_light_blink_yellow.svg': {
    'method': 'filter',
    'dark': {'#ff1a1c1e': '#ffaeaeae'}
  },
};
