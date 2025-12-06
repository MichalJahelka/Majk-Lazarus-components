{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit Majk;

{$warn 5023 off : no warning about unused units}
interface

uses
  HexControls, Meters, Switches, Gauges, Edits, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('HexControls', @HexControls.Register);
  RegisterUnit('Meters', @Meters.Register);
  RegisterUnit('Switches', @Switches.Register);
  RegisterUnit('Gauges', @Gauges.Register);
  RegisterUnit('Edits', @Edits.Register);
end;

initialization
  RegisterPackage('Majk', @Register);
end.
