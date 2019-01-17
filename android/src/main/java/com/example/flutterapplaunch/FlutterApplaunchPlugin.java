package com.example.flutterapplaunch;

import android.net.Uri;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.HashMap;
import java.util.Map;

/** FlutterApplaunchPlugin */
public class FlutterApplaunchPlugin implements MethodCallHandler {

  private final Registrar mRegistrar;

  private FlutterApplaunchPlugin(Registrar registrar) {
    this.mRegistrar = registrar;
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_applaunch");
    channel.setMethodCallHandler(new FlutterApplaunchPlugin(registrar));
  }

  @Override public void onMethodCall(MethodCall call, Result result) {
    if ("getPlatformVersion".equals(call.method)) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if ("getAppLaunchURLScheme".equals(call.method)) {
      result.success(getAppLaunchURLScheme());
    } else {
      result.notImplemented();
    }
  }

  private Map<String, String> getAppLaunchURLScheme() {
    Map<String, String> map = new HashMap<>();
    Uri uri = mRegistrar.activity().getIntent().getData();
    if (uri != null) {
      map.put("url", uri.getQuery());
      map.put("source", uri.getScheme());
    }
    return map;
  }
}
