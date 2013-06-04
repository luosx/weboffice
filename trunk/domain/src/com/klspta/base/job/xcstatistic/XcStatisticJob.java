package com.klspta.base.job.xcstatistic;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class XcStatisticJob implements org.quartz.Job{

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		InsertGPSStatistic.getInstance().insertGPSStatistic();
	}

}
