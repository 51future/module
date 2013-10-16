package com.bin.acode.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.management.ManagementFactory;

public class BinObject {
	/**
	 * <p>to connect to running and print histogram
	 *  of java object heap
	 * </p>
	 * @since  1.6
	 */
	public static void jobjHeap(){
		try {
			System.out.println(ManagementFactory.getRuntimeMXBean().getName());
			String pid = ManagementFactory.getRuntimeMXBean().getName().replaceAll("(\\d+)@.*", "$1");
			String cmd = "jmap -histo " + pid;
			System.out.println(cmd);
			Process process = Runtime.getRuntime().exec(cmd);
			BufferedReader breader = new BufferedReader(new InputStreamReader(process.getInputStream()));
			String buf;
			while ((buf = breader.readLine()) != null) {
				System.out.println(buf);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
}
