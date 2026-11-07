within cdl_models.Move.archived_20261016;
block Qualification "Qualification"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Qualification check of the air handling units for the fan speed limiting
demand flexibility strategy.
</p>
<p>
An air handling unit is considered to be qualified for fan speed limiting if
all of the following conditions are true:
</p>
<ul>
<li>the fan speed <code>fanSpe</code> is greater than
<code>fanSpeMin</code>,</li>
<li>the volumetric air flow rate <code>V_flow</code> of the variable air
volume served by the air handling unit is greater than
<code>VMin_flow</code>, and</li>
<li>the zone temperature <code>TZon</code> of the zone served by the air
handling unit is less than <code>TZonMax</code>.</li>
</ul>
<p>
Each air handling unit is evaluated independently, and the output is a vector
with one entry per air handling unit. For each unit, if all three conditions
are met, the unit is qualified for fan speed limiting and
<code>yQua[i] = true</code>. Otherwise, the unit is not qualified and
<code>yQua[i] = false</code>.
</p>
<p>
Each comparison includes a hysteresis to avoid chattering of the output when
the signal is close to its threshold. The fan speed and the volumetric air
flow rate are compared using the hysteresis <code>fanSpeHys</code> and
<code>VHys_flow</code>: their conditions switch to <code>true</code> when the
signal rises above its threshold and switch back to <code>false</code> when
the signal falls to the threshold minus the hysteresis. The zone temperature
is compared using the hysteresis <code>TZonHys</code>: its condition switches
to <code>true</code> when the temperature falls below <code>TZonMax</code>
and switches back to <code>false</code> when the temperature rises to
<code>TZonMax</code> plus the hysteresis.
</p>
</html>"));
end Qualification;
