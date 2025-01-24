package com.cs336.pkg;

import java.util.Map;

public class checkParams {
	public static String getValue(Map params, String key){
        String value = ((String[])params.get(key))[0];
        return value;
	}
}
