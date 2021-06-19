proc swapp_get_name {} {
  return "TMR Comparator Fault Inject Example"
}

proc swapp_get_description {} {
  return "MicroBlaze TMR Comparator fault injection example application."
}

proc swapp_is_supported_hw {} {
  return 1
}

proc swapp_is_supported_sw {} {
  return 1
}

proc swapp_generate {} {
}

proc swapp_get_supported_processors {} {
    return "microblaze";
}

proc swapp_get_supported_os {} {
    return "standalone";
}
