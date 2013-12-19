package com.klspta.web.cbd.yzt.jc.valueChange;

public class JbdkValueChange extends AbstractValueChange {

	@Override
	public boolean add(String ywGuid) {
		
		
		
		
		return false;
	}

	@Override
	public boolean delete(String ywGuid) {
		return false;
	}

	@Override
	public boolean modify(String ywGuid) {
		return add(ywGuid);
	}

	@Override
	public boolean modifyguid(String oldguid, String newguid) {
		// TODO Auto-generated method stub
		return false;
	}

}
