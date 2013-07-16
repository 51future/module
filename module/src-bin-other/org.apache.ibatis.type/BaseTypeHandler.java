package org.apache.ibatis.type;

import java.sql.CallableStatement;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import org.apache.ibatis.session.Configuration;

/**
 * 此类是mybatis在生成sql语句时使用的类型设定工具
 * 此类修改了原文件的setParameter方法,用此类覆盖原类文件,可在sql语句中不指定jdbcType,简化配置,
 * 
 * @author tmd
 * 
 */
public abstract class BaseTypeHandler<T> extends TypeReference<T> implements
		TypeHandler<T> {
	protected Configuration configuration;

	public void setConfiguration(Configuration c) {
		this.configuration = c;
	}

	public void setParameter(PreparedStatement ps, int i, T parameter,
			JdbcType jdbcType) throws SQLException {
		if (parameter == null) {
			if (jdbcType == null || jdbcType == JdbcType.OTHER) {
				try {
					boolean useSetObject = false;
					int sqlType = Types.NULL;
					try {
						DatabaseMetaData dbmd = ps.getConnection().getMetaData();
						String databaseProductName = dbmd.getDatabaseProductName();
						String jdbcDriverName = dbmd.getDriverName();
						if (databaseProductName.startsWith("Informix") || jdbcDriverName.startsWith("Microsoft SQL Server")) {
							useSetObject = true;
						} else if (databaseProductName.startsWith("Oracle")
								|| databaseProductName.startsWith("DB2")
								|| jdbcDriverName.startsWith("jConnect")
								|| jdbcDriverName.startsWith("SQLServer")
								|| jdbcDriverName.startsWith("Apache Derby")) {
							sqlType = Types.VARCHAR;
						}
					} catch (Throwable ex) {
						throw new TypeException("Could not check database or driver name", ex);
					}
					if (useSetObject) {
						ps.setObject(i, null);
					} else {
						ps.setNull(i, sqlType);
					}
				} catch (SQLException e) {
					throw new TypeException("Error setting null parameter.  Most JDBC drivers require that the JdbcType must be specified for all nullable parameters. Cause: " + e, e);
				}
			} else {
				ps.setNull(i, jdbcType.TYPE_CODE);
			}
		} else {
			setNonNullParameter(ps, i, parameter, jdbcType);
		}
	}

	public T getResult(ResultSet rs, String columnName) throws SQLException {
		T result = getNullableResult(rs, columnName);
		if (rs.wasNull()) {
			return null;
		} else {
			return result;
		}
	}

	public T getResult(ResultSet rs, int columnIndex) throws SQLException {
		T result = getNullableResult(rs, columnIndex);
		if (rs.wasNull()) {
			return null;
		} else {
			return result;
		}
	}

	public T getResult(CallableStatement cs, int columnIndex)
			throws SQLException {
		T result = getNullableResult(cs, columnIndex);
		if (cs.wasNull()) {
			return null;
		} else {
			return result;
		}
	}

	public abstract void setNonNullParameter(PreparedStatement ps, int i,
			T parameter, JdbcType jdbcType) throws SQLException;

	public abstract T getNullableResult(ResultSet rs, int columnIndex)
			throws SQLException;

	public abstract T getNullableResult(ResultSet rs, String columnName)
			throws SQLException;

	public abstract T getNullableResult(CallableStatement cs, int columnIndex)
			throws SQLException;
}