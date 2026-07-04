# Intel MIPI (IPU6) webcam stack. Import only on laptops with an IPU6 camera.
{ ... }:

{
  hardware.ipu6 = {
    enable = true;
    # ipu6 for Tiger Lake
    # ipu6ep for Alder Lake / Raptor Lake
    # ipu6epmtl for Meteor Lake.
    platform = "ipu6ep";
  };
}
