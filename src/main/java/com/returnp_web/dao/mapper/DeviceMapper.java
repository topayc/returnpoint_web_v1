package com.returnp_web.dao.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface DeviceMapper {

	int  registPushToken(HashMap<String, Object> params);

	int  updateDeviceInfo(HashMap<String, Object> params);

	HashMap<String,Object>  selectDeviceInfo(HashMap<String, Object> params);

}
