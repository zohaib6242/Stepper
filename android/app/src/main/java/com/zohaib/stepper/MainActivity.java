package com.zohaib.stepper;

import android.os.Debug;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.google.gson.Gson;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private String CHANNEL = "com.zohaib.stepper/channelStepper";
    private MethodChannel channel;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger() , CHANNEL);
        channel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
                Log.w("getStepperValues" , "calling from native");
                if (methodCall.method.equals("getStepperValues")) {
                    List<StepItem> steps = new ArrayList<>();
                    steps.add(new StepItem(1,"Select campaign settings" , "For each ad campaign that you create, you can control how much your're willing to spend on clicks and conversions,which networks and geographical locations you want your ads to show on, and more."));
                    steps.add(new  StepItem(2,"Create an ad group" , "Step discribed how you can create ad group?"));
                    steps.add(new  StepItem(3,"Create an ad" , "Step explained how you can create a great ad?"));
                    String json = new Gson().toJson(steps);
                    Log.w("getStepperValues" , "returning from native : " + json);
                    result.success(json);
                }
            }
        });
    }
}
