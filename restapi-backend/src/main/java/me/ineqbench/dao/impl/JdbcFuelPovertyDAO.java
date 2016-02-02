package me.ineqbench.dao.impl;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

import me.ineqbench.dao.FuelPovertyDAO;
import me.ineqbench.dao.TransportDAO;
import me.ineqbench.dbRequestPOJOs.Range;
import me.ineqbench.dbResponsePOJOs.ResponseTuplePOJO;
import me.ineqbench.mappers.EthnicityResponseMapper;

public class JdbcFuelPovertyDAO implements FuelPovertyDAO{
	
	private DataSource dataSource;
	private SimpleJdbcCall jdbcCall;

	
	public void setDataSource(DataSource dataSource) {
	 
		jdbcCall = new SimpleJdbcCall(dataSource)
	    .withoutProcedureColumnMetaDataAccess()
	    .withProcedureName("getFuelPovertyOutput")
	    .returningResultSet("fuelPoverty", new EthnicityResponseMapper());
	}

	@Override 
	public List<ResponseTuplePOJO> findData(String gender, Range range) {
    
		jdbcCall.declareParameters(new SqlParameter("start_age", Types.INTEGER));
		jdbcCall.declareParameters(new SqlParameter("end_age", Types.INTEGER));
		
		Map mapResult = jdbcCall.execute(range.getStartOfRange(),range.getEndOfRange());
		List<ResponseTuplePOJO> result = (List<ResponseTuplePOJO>)mapResult.get("fuelPoverty");
		return result;
	}
	
}