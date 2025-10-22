
// http://example.org#cdl_models.Controls.multiple_zone_ratchet
const single_zone_ratchet_cooling_89149cd0 = require("./Subsequences/single_zone_ratchet_cooling");
const single_zone_ratchet_heating_7fc1a8c9 = require("./Subsequences/single_zone_ratchet_heating");
const temdifselectionmax_1c237ae4 = require("./Subsequences/temDifSelectionMax");
const temdifselectionmin_1c237bd2 = require("./Subsequences/temDifSelectionMin");

module.exports = (
  {
		loaSheCooAct = true,
		loaSheHeaAct = true,
		loadShedDurationTypical = 7200,
		loadShedTempAmountTypical = 5,
		nZones = 3,
		TRat = 1,
		samplePeriodRatchet = loadShedDurationTypical*0.3333*TRat/loadShedTempAmountTypical/nZones,
		reboundDuration = 3600,
		TReb = 1,
		samplePeriodRebound = reboundDuration*TReb/loadShedTempAmountTypical/nZones,
		TRatThreshold = 0.5,
    } = {}
) => {
  // http://example.org#cdl_models.Controls.multiple_zone_ratchet.single_zone_ratchet_cooling
  const single_zone_ratchet_coolingFn = single_zone_ratchet_cooling_89149cd0({ samplePeriodRatchet: samplePeriodRatchet, samplePeriodRebound: samplePeriodRebound, TRat: TRat, TRatThreshold: TRatThreshold, TReb: TReb });
  // http://example.org#cdl_models.Controls.multiple_zone_ratchet.single_zone_ratchet_heating
  const single_zone_ratchet_heatingFn = single_zone_ratchet_heating_7fc1a8c9({ samplePeriodRatchet: samplePeriodRatchet, samplePeriodRebound: samplePeriodRebound, TRat: TRat, TRatThreshold: TRatThreshold, TReb: TReb });
  // http://example.org#cdl_models.Controls.multiple_zone_ratchet.temDifSelectionMaxCooRat
  const temDifSelectionMaxCooRatFn = temdifselectionmax_1c237ae4({ nZones: nZones });
  // http://example.org#cdl_models.Controls.multiple_zone_ratchet.temDifSelectionMinCooReb
  const temDifSelectionMinCooRebFn = temdifselectionmin_1c237bd2({ nZones: nZones });
  // http://example.org#cdl_models.Controls.multiple_zone_ratchet.temDifSelectionMinHeaRat
  const temDifSelectionMinHeaRatFn = temdifselectionmin_1c237bd2({ nZones: nZones });
  // http://example.org#cdl_models.Controls.multiple_zone_ratchet.temDifSelectionMaxHeaReb
  const temDifSelectionMaxHeaRebFn = temdifselectionmax_1c237ae4({ nZones: nZones });

  return (
    { TZon, TZonCooSetCur, TZonHeaSetCur }
  ) => {
    const single_zone_ratchet_cooling = single_zone_ratchet_coolingFn({ TZon: TZon, TZonCooSetCur: TZonCooSetCur });
    const single_zone_ratchet_heating = single_zone_ratchet_heatingFn({ TZon: TZon, TZonHeaSetCur: TZonHeaSetCur });
    const temDifSelectionMaxCooRat = temDifSelectionMaxCooRatFn({ ignoreFlag: single_zone_ratchet_cooling.reachTZonCooSetMax });
    const temDifSelectionMinCooReb = temDifSelectionMinCooRebFn({ ignoreFlag: single_zone_ratchet_cooling.reachTZonCooSetNom });
    const temDifSelectionMinHeaRat = temDifSelectionMinHeaRatFn({ ignoreFlag: single_zone_ratchet_heating.reachTZonHeaSetMin });
    const temDifSelectionMaxHeaReb = temDifSelectionMaxHeaRebFn({ ignoreFlag: single_zone_ratchet_heating.reachTZonHeaSetNom });

    return { TZonCooSetCom: single_zone_ratchet_cooling.TZonCooSetCom, TZonHeaSetCom: single_zone_ratchet_heating.TZonSetHeaCom };
  }
}
