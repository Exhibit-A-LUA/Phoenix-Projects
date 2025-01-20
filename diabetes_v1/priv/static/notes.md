# Calculations Used

| Term | Calculation |
| ---------- | ---------- |
| **ICR (Insulin to Carbs Ratio)** | (Total Daily Carbs X 1.5) / Total Rapid Insulin Units |
| **ICR (Alternative Calculation)** | (5.7*body weight in kilos)/Total Daily Dose |
| **ISF (Insulin Sensitivity Factor)** | 1700 / Total Daily Insulin Units |
| **Blood sugar Impact from Carbs** | ISF / ICR = increase BG per gram of carbs |
| **IOB (Insulin On Board)**	| Sum for each Dose [n]  (Insulin Dose [n] – ((0.3 X Dose [n]) per hour)) |
| **COB (Carbs on Board)** |	(Meal Carbs + Meal FPU Carb Equivalent) – (0.5g per minute) |
| **Meal Carbs Units** | (Meal Carbs / ICR) |
| **BG Correction Units** | ((Current BG – Target BG) / ISF) |
| **FPU (Fat/Protein Unit)** | ((Meal Protein grams * 4) + (Meal Fat grams * 9)) / 100 |
| **FPU Carb Equivalent** | FPU X Conversion Factor note: I use Conversion Factor of 10 (how to tweak?) |
| **Split Units** | FPU Carb Equivalent/ ICR |
| **Split Dose If** |  Meal Carbs > 60g |
| | Meal Protein > 30g |
| | Fat grams > (0.333 X Meal Weight) |
| | (FPU Carbs > (0.3 X Meal Carbs)) AND (Protein grams > 15) |
| **Meal Units** | Meal Carb Units + Split Units (if no split) |
| **Time for split** | At least 2 hours, when BG starts to rise |
| **Future Predicted Glucose** | Factors to improve accuracy + ((Active Carbs) / ICR) x ISF - (Active Insulin x ISF) |
| **ISF w/ BG** | 277700 / (BG * TDD) |
| **Standard Deviation** | Find the mean BG, Add all the squares of each n differences from the mean, Divide by (n-1), Square Root |
| **CV or GV (Glucose Variablility)** | Standard Deviation / Average Daily Blood Glucose |

**Came across this comment by Chris on a Loop and Learn FB post about ISF w/ BG**

>There’s some changes that have been made based on feedback from people testing in AAPS (and FreeAPS X), so the “277700” equation is largely outdated.

>One of the things we’ve discovered is that basal needs are at least somewhat disconnected from correction and carb dosing needs, so an “adjustment factor” related to the basal/bolus ratio needs to be applied for many individuals.

>There are also variances due to changes in absorption speed with different insulins, which are accounted for in the latest version which is pending inclusion in the official AAPS branch. The same adjustment also explains why the effects of BG-dependent changes in insulin sensitivity are largely masked in clinical clamp studies, and why Affrezza dosing is wonky.

>Most of the things referenced above have already been identified, accounted for mathematically and are moot points in the latest iterations.

>The shape of the curve has also changed slightly from a 1/X to a 1/ln(X), which stretches and contracts.

>And to Joshua Bohmer’s point, variances in resistance ARE accounted for.

>This has been an iterative process, identifying outliers for whom things don’t work, and adapting the underlying math to allow it to flex, change and stretch according to individual needs. I’ve even identified an additional level of natural logs inside of the current equation.

# Exercise

## When to exercise

| BG | Carbohydrates and Glucose Management Strategies |
| ---------- | ---------- |
| <90 | Ingest 10-20g of carbs before starting ANY exercise. Delay exercise until BG > 90 and rising |
| 90-124 | Ingest 10-20g of carbs before starting AEROBIC exercise. |
| 126-180 | No carbs needed before start but soon afterwards. Aerobic and Anaerobic exercise can be started |
| 182-252 | Aerobic and Anaerobic exercise can be started |
| >252 | Check blood ketones. If B-Ketones > 0.6mmol action required before exercise |
| Notes | More carbs will be needed with continuous exercise |
|  | 60 to 90 minutes after dose, insulin will be working hardest so BG may drop quickly, so take carbs to boose BG if about to exercise |
|  | At least 3 hours after last bolus --> less risk of a low |
|  | Higher risk of low blood sugars overnight |
|  | If FIT, less impact on blood sugars |
|  | Exercise uses around 1g of carbs per kg body weight per hour |
|  | Short bursts of Intense exercise can lead to high BG for up to 2 hours post exercise |

## Notes on Physical Activity
- Cut back Bolus doses prior to an activity (25%, 33%, 50%)
- Snack prior to activity
- If prolonged activity, cut back on Basal Insulin well ahead of time
- Its a balancing act because adrenalin raises BG, so if its a competition its different

### Watch out for Delayed Onset Hypogglycemia folowing High-Intensity exercise or Extended Duration Activity (may occur up to 24 Hours after)
- cut back on Basal Insulin
- Consume slow digesting (Low-GI) snack that we don't dose for
- Lower Bolus doses for a while after 
- Set alarms at least 10 above above low threshold (70) on CGM to catch impending low (set alarm to 85 or 90)

# General guidance 

| Type of Exercise | Glucose Exspectation |
| --- | --- |
| Lower Intensity Longer Duration | Expect Drop in Glucose |
| Higher Intensity Shorter Duration | Expect Spike in Glucose |
| Combination of aerobic and anaerobic | Expect Glucose to fluctuate, can drop or spike |

## Bolus Changes to account for exercise

| Type of Exercise | Meal Before Exercise | | Meal After Exercise |
| --- | --- | --- | --- |
|  | Lasting 30 to 45 minutes | Lasting > 45 minutes |  |
| Continuous, moderate to vigorous intensity aerobic activity  (Jogging/running, moderate swimming, bicycling, cross country etc) | 25-50% bolus reduction | 50-75% bolus reduction | Up to 50% bolus reduction |
| Mixed aerobic and anaerobic burst activity (Hopping, skipping, dance, gymnastics, tag, dodgeball, field and team sports, individual racquet sports etc) | 25% bolus reduction | 50% bolus reduction | Up to 50% bolus reduction |

## General Notes 

- If 70% Time in Range or above you will not develop retinopathy
- Less Insulin resistant in the night (low cortisol) so higher ISF ie need less insulin
- More Insulin Resistant in the morning (cortisol peaks) so lower ISF ie need more insulin
- A potential calculation for Breakfast ICR is 300/TDD (or maybe 360/TDD)
- A potential calculation for Other Meals ICR is 400/TDD (or maybe 450/TDD)
- ISF 6 to 8 throughout the day (Not sure why I wrote this)
- Should be multiple BG targets, Day Targets, Night Targets etc
- Insulin Dose Changes over time. Puberty (growth Hormone causes insulin resistance) so TDD ~= 1-2 Units per kg body weight, After stop growing TDD ~= 0.5 to 1 Units per kg body weight
- Goal is to keep CV < 33% (ie Standard Deviation should be < 1/3 of Average Blood Sugar)
- Post meal BG should be tested 3-4 hours after eating NOT 2
- Morning doses are usually Higher than lunch and dinner because waking from 'fasting state' food digests faster,  raises BG faster
- 30% of insulin is used per hour so, after 1 hour 70% left, after 2 40% left, after 3 10% left
- Amount of Insulin left (On Board) should be deducted from next dose otherwise insulin stacks up

## Extend timing of meal Insulin when
- Very large portions
- Meal is prolonged
- Flood is low-glycemic (pasta, legumes, dairy)
- High fat foods
- **Can** : delay injection, give it after meal
- **Can** : split it into 2 parts, half with meal and half an hour or two later
- **-OR-** : give yourself a shot of regular insulin instead of rapid acting

## Can Split Basal Insulin
- Even though it's supoosed to be 24 hours, you might find things change 18 to 20 hours after the dose
- So, split the basal half each 12 hours works more optimally
- May not be 50/50, teens tend to have an increased insulin need overnight, then less in the morning to carry you through the day when you are more active

## Carbs On Board
- In addition, we discovered that the rate at which BG rises after carb consumption is fairly constant, both across food types and over time. 
- For n=1 (type 1 diabetes), we observed that carbohydrates are digested and absorbed at a rate of approximately 30g/hour (0.5g/minute), 
- and that this rate is relatively constant beginning after the initial 15-minute lag, and lasting until the last of the carbs are absorbed (up to 4 hours later, in the case of a large 120-carb meal).

## Don't know why I wrote this or what it means

- Gluten Antibiotics
- 
- Fat First - Good ghee (pure organic)
- Gluten - Khapli wheat (less gluten)
- Plastic - less
- molecular mimic... auto-immune... gluten... READ UP
- Ashwagandha... stress shield- product... cureveda
- Gut Microbiome, Fermented Foods, Exercise, Sleep, Stress Management. Avoid artifical sweeteners

## Basal Rate Evaluation - Very Important to Get This Right
- ISF (Insulin Sensitivity Factor), Too low will cause you to get lows. Too high wont bring you down to target
- ICR (Insulin/Carb Ratio), Too low will give too much insulin and cause you to get lows. Too high wont give enough insulin and you will get highs

## Effects of Different Types of Carbs
|Type of Carb|Effect Type|Dose Time|Examples|Absorption Rate|
|--|--|--|--|--|
| Fast Acting Carbs | Will raise blood sugar about 30 minutes after eating | Take dose 15-20 minutes before meal | Cereal, white rice, breads, potatoes, snack food | 2 hour absorbtion |
| Medium Carbs Foods (Protein) | Will raise blood sugar about 60 minutes after eating | Take dose 10-15 minutes before meal | Higer Fibre, Moderate proteins and fats = most meals | 3-4 hour absorption |
| Slow Carbs (Fats) or >60g carbs | Will linger around for hours and may need second dose |  | Fast Food, Fried Food, Pizza, Creamy Sauces, Full Fat Dairy | 4-6 hour absorption |

- **Carbs are quick, then protein, then fat**

## Changes with Time of Day

|Factor|Times|example numbers|
|--|--|--|
| ICR | Midnight to 7am | 20 |
| ICR | 7am to 9:30am | 17 |
| ICR | 9:30am to Midnight | 18 |
| ISF | Midnight to 3am | 170 |
| ISF | 3am to 7am | 175 |
| ISF | 7am to 8am | 210 |
| IFS | 8am to 9pm | 110 |
| ISF | 9pm to 11pm | 78 |
| ISF | 11pm to 11:30pm | 100 |
| ISF | 11:30pm to Midnight | 155 |
| BG | Midnight to 8am | 85 |
| BG | 8am to 8pm | 85 to 100 |
| BG | 8pm to Midnight | 80 to 90 |

## Basal Dose Percentage is Important
- If you frequently go low or frequently go high after meals:
- Check your basal/carb bolus balance. 
- If your basal rates make up more than 55% or 60% of your TDD, this may be the source for lows.
- If basals make up only 40% or 45% of your TDD, this may be a source for highs.
- Change your ICR (CarbF): raise it if you are getting frequent lows, lower it for frequent highs.
- Improve your carb counting, especially if your postmeal glucoses are erratic or you frequently go high.

## Insulin Sensitivity Test
- 1 unit insulin, wait 6 hours, drop in BG = ISF
- Eat known carbs, wait for rise, Total Rise / grams of carbs = Rise per gram
- ICR x Rise per gram = ISF

# Hypoglycemia (Low Blood Sugar)
- <70, Mild – should use this as cut off for a low
- <55, Moderate - functional imparement starts to occur
- Target is, <= 3 Mild per week, No severe bouts, Rapid recovery without overcompensation, <3% time in a day in tidepool

## Hypoglycemia Treatment
- Check glocose first CGM may be inaccurate (see a lot of false lows with the Libre)
- Treat with rapid acting carb in the right amount (High Glycemic Index) [Liquid > solid; Warm > cold; Low Fat > High Fat; Low Fibre > High Fibre]
- Post treatment re-check
- Watch out for Compression Lows (pressure on CGM causes it to record a low which immediately goes up)
- High GI Foods, Saltines, Dry Cereal, White Bread, Graham Crackers, Vanilla Wafers, Jelly Beans, Gatorade
- Dextrose is BEST, Glucose Tabs/Gels/Drinks, Sweet Tarts, Smarties, Spree, Air Heads, Nerds, Runts, Pixy Stix

## Grams of carbs and your weight
|Weight|Rise per g carbs|Carbs required to get to 120 mg/dl|
|---|---|---|
| 32-45 | 6 |in 70's need 8g, in 60's need 9g, in 50's need 11g, in 40's need 13g, <40 need 14g|
| 45-64 | 5 |in 70's need 9g, in 60's need 11g, in 50's need 13g, in 40's need 15g, <40 need 17g|

- Note if arrow is straight down add 25% more
- Note if double straight down arrow add 50% more
- CGM's have a very long lag time when stress hormones in the body, so won't necessarily see it rise of a long time
- Finger stick test at 15 mins, as long as started to rise its OK
- If no drop, then repeat treatment based on updated BG and updated arrows

# SEVERE Hypoglycemia Treatment
- **Gvoke HypoPen: 2-step SC self-injector; needle unseen; 2 dose options (wt based); 2.5yr shelf life**
- Gvoke Kit: Vial/Syringe; **Allows for micro-dosing***
- Baqsimi Nasal Spray: Dry powder infusion; Unaffafected by congestion; **One dose size; Can be uncomfortable; Difficult to administer to moving subject**
- Zegalogue Pen: 2-step self injection; Needle unseen; **1 dose option**

# FIASP Notes
- Peak Activity is 55 mins (this is Not absolute, need to test)
- Duration of Insulin Action (DIA) is 360 mins to the very tail, (this is Not absolute, need to test)
- Insulin Delay is 10 mins, so add this to above numbers ie Peak actually 65 mins after bolus

# Useful Weights

|Product|Weight in grams|
|---|---|
| Iceberg Lettuce Medium Head | 539 |
| Cheddar 1 Slice | 28 |
| Celery Stalk | 40 |
| 1 tbsp grated coconut | 4.75 |
| 1 cup grated coconut | 80.3 |
| 1 Bay Leaf | 0.33 |
| 1 tsp Italian Seasoning | 2.84 |
| 1 tbsp green chilli | 7.39 |
| 1 cup mint leaves | 30 |
| 1 cup chopped tomtoes | 180 |

# Useful Conversions
|Product|Size in mililitres|Weight in grams|grams per ml|
|---|---|---|---|
| Mayonnaise | 80 | 77.76 | 0.97 |
| Sour Cream | 550 | 562.58 | 1.02 |
| Cream Cheese | 550 | 537.00 | 0.98 |
| Orange Juice | 120 | 126.19 | 1.05 |
| Lemon Juice | 180 | 189.29 | 1.05 |
| Water | 240 | 240 | 1 |
| Feta | 120 | 65 | 0.54 |
| Greek Yoghurt | 120 | 90 | 0.75 |
| Whipping Cream | 180 | 175.75 | 0.98 |
| Tomato Puree | 180 | 171 | 0.95 |
| Olive Oil | 60 | 83.7 | 1.4 |
| Beef Broth | 240 | 243.5 | 1.01 |
| Salsa | 120 | 114 | 0.95 |
| Almond Milk | 180 | 185.6 | 1.03 |
| Dark Chocolate | 180 | 200 | 1.11 |
| Soy Sauce | 1 | 1.12 | 1.12 |
| Vinegar | 60 | 58.3 | 0.97 |
| Nuts | 60 | 38 | 0.63 |
| Salt | 1 | 1.15 | 1.15 |
| Milk | 125 | 130 | 1.04 |
| Ice Cream | 100 | 76 | 76 |

