/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)                                                             \
  {((hex >> 24) & 0xFF) / 255.0f, ((hex >> 16) & 0xFF) / 255.0f,               \
   ((hex >> 8) & 0xFF) / 255.0f, (hex & 0xFF) / 255.0f}

static const float rootcolor[] = COLOR(0xffffeaff);
static uint32_t colors[][3] = {
    /*               fg          bg          border    */
    [SchemeNorm] = {0x000000ff, 0xffffeaff, 0x888888ff},
    [SchemeSel] = {0x000000ff, 0x57864Eff, 0xB85C57ff},
    [SchemeUrg] = {0x000000ff, 0xB85C57ff, 0x57864Eff},
};
