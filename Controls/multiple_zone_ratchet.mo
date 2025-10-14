within cdl_models.Controls;
model multiple_zone_ratchet

  parameter Integer nZones=3;
  Subsequences.single_zone_ratchet_cooling single_zone_ratchet_cooling[nZones](
      TRatThreshold=1)
    annotation (Placement(transformation(extent={{-30,22},{20,50}})));
  Subsequences.ratchetSelectionCooling ratchetSelectionCooling(nZones=nZones)
    annotation (Placement(transformation(extent={{-100,56},{-80,76}})));
  Subsequences.reboundSelectionCooling reboundSelectionCooling(nZones=nZones)
    annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end multiple_zone_ratchet;
