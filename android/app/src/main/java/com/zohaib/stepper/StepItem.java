package com.zohaib.stepper;

public class StepItem{

    public int stepNumber = 3;
    public String stepTitle = "";
    public String stepDescription = "";

    public StepItem(int stepNumber, String title, String description){
        this.stepNumber = stepNumber;
        this.stepTitle = title;
        this.stepDescription = description;
    }
}
