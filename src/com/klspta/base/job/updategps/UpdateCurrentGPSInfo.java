package com.klspta.base.job.updategps;


import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.stereotype.Component;

@Component
public class UpdateCurrentGPSInfo implements Job {
	
	
	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		System.out.print("更新当前信息！");
	}
}
