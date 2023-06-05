import 'package:inside_out/domain/emotion.dart';

final Map<Emotion, List<String>> secondaryEmotionsMap = {
  Emotion.sadness: ['anxious', 'abandoned', 'despairing', 'depressed', 'lonely', 'bored'],
  Emotion.happiness: ['optimistic', 'intimate', 'peaceful', 'powerful', 'accepting', 'proud'],
  Emotion.anger: ['threatened', 'hateful', 'unhinged', 'aggressive', 'frustrated', 'distant'],
  Emotion.fear: ['hurt', 'humiliated', 'rejected', 'submissive', 'insecure', 'scared'],
  Emotion.surprise: ['interested', 'surprised', 'confused', 'astonished', 'effusive', 'jubilant'],
  Emotion.disgust: ['critical', 'disapproving', 'disappointed', 'terrible', 'avoidant', 'guilty'],
};

final Map<Emotion, Map<String, List<String>>> tertiaryEmotionsMaps = {
  Emotion.sadness: _tertiaryEmotionsSadnessMap,
  Emotion.happiness: _tertiaryEmotionsHappinessMap,
  Emotion.anger: _tertiaryEmotionsAngerMap,
  Emotion.fear: _tertiaryEmotionsFearMap,
  Emotion.surprise: _tertiaryEmotionsSurpriseMap,
  Emotion.disgust: _tertiaryEmotionsDisgustMap,
};

final Map<String, List<String>> _tertiaryEmotionsSadnessMap = {
  'anxious': ['yearning', 'overwhelmed'],
  'abandoned': ['ignored', 'discriminated'],
  'despairing': ['powerless', 'vulnerable'],
  'depressed': ['inferior_depressed', 'empty'],
  'lonely': ['abandoned', 'alienated'],
  'bored': ['apathetic', 'indifferent'],
};

final Map<String, List<String>> _tertiaryEmotionsHappinessMap = {
  'optimistic': ['inspired', 'receptive'],
  'intimate': ['playful', 'sensitive'],
  'peaceful': ['hopeful', 'loving'],
  'powerful': ['courageous', 'provocative'],
  'accepting': ['fulfilled', 'respected'],
  'proud': ['confident', 'important'],
};

final Map<String, List<String>> _tertiaryEmotionsAngerMap = {
  'threatened': ['insecure', 'jealous'],
  'hateful': ['resentful', 'violated'],
  'unhinged': ['enraged', 'rabid'],
  'aggressive': ['provoked', 'hostile'],
  'frustrated': ['angry', 'irritated'],
  'distant': ['withdrawn', 'suspicious'],
};

final Map<String, List<String>> _tertiaryEmotionsFearMap = {
  'hurt': ['devastated', 'grieved'],
  'humiliated': ['ridiculed', 'disrespected'],
  'rejected': ['disturbed', 'inadequate'],
  'submissive': ['insignificant', 'indignant'],
  'insecure': ['inferior_insecure', 'poor'],
  'scared': ['frightened', 'terrified'],
};

final Map<String, List<String>> _tertiaryEmotionsSurpriseMap = {
  'interested': ['entertaining', 'curious'],
  'surprised': ['impressed', 'dismayed'],
  'confused': ['disillusioned', 'perplexed'],
  'astonished': ['astonished', 'stunned'],
  'effusive': ['restless', 'energetic'],
  'jubilant': ['lighthearted', 'euphoric'],
};

final Map<String, List<String>> _tertiaryEmotionsDisgustMap = {
  'critical': ['sarcastic', 'sceptical'],
  'disapproving': ['judgmental', 'abhorred'],
  'disappointed': ['repugnant', 'rebellious'],
  'terrible': ['repulsive', 'detestable'],
  'avoidant': ['aversive', 'indecisive'],
  'guilty': ['tormented', 'ashamed'],
};

final Map<Emotion, List<String>> bodySensations = {
  Emotion.sadness: [
    'tightness_chest',
    'empty_feeling_stomach',
    'fatigue_lack_energy',
    'changes_appetite',
    'sleep_disturbances',
    'physical_sensitivity',
  ],
  Emotion.happiness: [
    'feeling_lightness',
    'smile_laughter',
    'increased_energy',
    'feeling_warmth',
    'increased_agility_coordination',
    'wellBeing',
  ],
  Emotion.anger: [
    'increased_body_temperature',
    'muscle_tension',
    'increased_heart_rate',
    'rapid_shallow_breathing',
    'sweating',
    'pentUp_energy',
  ],
  Emotion.fear: [
    'increased_heart_rate',
    'tightness_chest',
    'rapid_shallow_breathing',
    'muscle_tension',
    'sweating',
    'feeling_weakness',
  ],
};

final Map<Emotion, List<String>> behaviours = {
  Emotion.sadness: [
    'crying',
    'withdrawal_isolation',
    'decreased_energy',
    'loss_interest_pleasure',
    'appetite_disturbances',
    'sleeping_difficulties',
    'poor_body_posture',
    'facial_expressions_apathy_discouragement',
  ],
  Emotion.happiness: [
    'smile_laughter',
    'increased_energy',
    'sharing',
    'positive_expression',
    'sociability',
    'increased_creativity',
    'feeling_gratitude'
  ],
  Emotion.anger: [
    'aggressive_verbal_expression',
    'physical_aggression',
    'impulsive_behaviours',
    'withdrawal_isolation',
    'alterations_communicative_behaviour',
    'tense_agitated_bodily_movements',
  ],
  Emotion.fear: [
    'fight_flight',
    'freezing',
    'increased_attention',
    'anxiety',
    'increased_heart_breathing_rate',
    'sweating'
  ],
};
