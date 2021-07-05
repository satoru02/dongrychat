const isMobile = function(display_size) {
  if (display_size < 600) {
    return true
  } else {
    return false
  }
}

const isTablet = function(display_size) {
  if (display_size < 960) {
    return true
  } else {
    return false
  }
}

export { isMobile, isTablet }