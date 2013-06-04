package com.klspta.base.job.updategps;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;

@Component
public class UpdateHistoryGPSInfo extends AbstractBaseBean implements Job {
	
	
	public void execute(JobExecutionContext context) throws JobExecutionException {
	}

}
