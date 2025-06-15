{inputs,...}:{
  # Simple overlay to access unstable packages through unstable.package
  default = final: prev: {
    unstable = import inputs.unstable {
      system = prev.system;
      config.allowUnfree = true;
    };
  };
}