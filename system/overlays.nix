{inputs,...}:{
  # Simple overlay to access unstable packages through unstable.package
  default = final: prev: {
    unstable = import inputs.unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}