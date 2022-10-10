class StepItem{
  int stepNumber = 3;
  String stepTitle = "";
  String stepDescription = "";

  StepItem(int stepNumber, String title, String description){
    this.stepNumber = stepNumber;
    this.stepTitle = title;
    this.stepDescription = description;
  }

  StepItem.fromJson(Map<String, dynamic> json)
      :
        stepNumber = json['stepNumber'],
        stepTitle = json['stepTitle'],
        stepDescription = json['stepDescription'];

  Map<String, dynamic> toJson() => {
    'stepNumber': stepNumber,
    'stepTitle': stepTitle,
    'stepDescription': stepDescription,
  };
}