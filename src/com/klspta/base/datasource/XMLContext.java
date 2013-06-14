package com.klspta.base.datasource;

public class XMLContext {
    public static final String head1 = 
        "<?xml version=\"1.0\" encoding=\"GB2312\"?>" +
            " \n <beans xmlns=\"http://www.springframework.org/schema/beans\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:context=\"http://www.springframework.org/schema/context\" xmlns:tx=\"http://www.springframework.org/schema/tx\"" +
            " \n xmlns:jdbc=\"http://www.springframework.org/schema/jdbc\" xmlns:p=\"http://www.springframework.org/schema/p\" " +
            " \n xsi:schemaLocation=\"http://www.springframework.org/schema/beans   " +
            " \n http://www.springframework.org/schema/beans/spring-beans-3.0.xsd   " +
            " \n http://www.springframework.org/schema/context   " +
            " \n http://www.springframework.org/schema/context/spring-context-3.0.xsd" +   
            " \n http://www.springframework.org/schema/tx   " +
            " \n http://www.springframework.org/schema/tx/spring-tx-3.0.xsd" +   
            " \n http://www.springframework.org/schema/jdbc   " +
            " \n http://www.springframework.org/schema/jdbc/spring-jdbc-3.0.xsd\">" +
            " \n <bean class=\"org.springframework.beans.factory.config.PropertyPlaceholderConfigurer\">" +
            " \n    <property name=\"locations\">" +
            " \n         <value>file:#JDBCFILEPATHlocaldatabase.properties</value>" +
            " \n    </property>" +
            " \n </bean>";
    public static final String head2 = " \n </beans>";
    public static final String bean1 = 
        " \n <bean id=\"#Name\" class=\"org.springframework.jdbc.datasource.DriverManagerDataSource\" lazy-init=\"false\" scope=\"singleton\" >" +
    " \n <property name=\"driverClassName\" value=\"${#Name.jdbc.driverClassName}\" />" +
    " \n <property name=\"url\" value=\"${#Name.jdbc.url}\" />" +
    " \n <property name=\"username\" value=\"${#Name.jdbc.username}\" />" +
    " \n <property name=\"password\" value=\"${#Name.jdbc.password}\" />" +
    " \n </bean>";
    
    public static final String bean2 = " \n <bean id=\"#NameTemplate\" class=\"org.springframework.jdbc.core.JdbcTemplate\" lazy-init=\"false\" scope=\"singleton\">" +
        " \n <property name=\"dataSource\">" +
         " \n    <ref bean=\"#Name\" />" +
        " \n </property>" +
    " \n </bean>";
    
    public static final String jdbc = 
    "#Name.jdbc.driverClassName=#ClassName" + //oracle.jdbc.driver.OracleDriver
    "\n#Name.jdbc.url=#url" + //jdbc:oracle:thin:@gisserver:1521:zfjc
    "\n#Name.jdbc.username=#username" + //sde
    "\n#Name.jdbc.password=#password\n"; // sde
    
    public static final String workflow = " \n <bean id=\"springHelper\" class=\"org.jbpm.pvm.internal.processengine.SpringHelper\" >" + 
    "\n <property name=\"jbpmCfg\" value=\"com/klspta/base/workflow/conf/jbpm.cfg.xml\"></property>" +
    "\n </bean>" +
    "\n <bean id=\"processEngine\" factory-bean=\"springHelper\" factory-method=\"createProcessEngine\" />" +
    "\n <bean id=\"sessionFactory\" class=\"org.springframework.orm.hibernate3.LocalSessionFactoryBean\">" +
    "\n <property name=\"dataSource\" ref=\"WORKFLOW\" />" +
    "\n <property name=\"mappingResources\">" +
    "\n <list>" +
    "\n <value>jbpm.repository.hbm.xml</value>" +
    "\n <value>jbpm.execution.hbm.xml</value>" +
    "\n <value>jbpm.history.hbm.xml</value>" +
    "\n <value>jbpm.task.hbm.xml</value>" +
    "\n <value>jbpm.identity.hbm.xml</value>" +
    "\n </list>" +
    "\n </property>" +
    "\n <property name=\"hibernateProperties\">" +
    "\n   <props>" +
    "\n  <prop key=\"hibernate.dialect\">org.hibernate.dialect.OracleDialect</prop>" +
    "\n  <prop key=\"hibernate.hbm2ddl.auto\">update</prop>" +
    "\n   </props>" +
    "\n </property>" +
    "\n  </bean>" +
    "\n <bean id=\"transactionManager\" class=\"org.springframework.orm.hibernate3.HibernateTransactionManager\">" +
    "\n   <property name=\"sessionFactory\" ref=\"sessionFactory\" />" +
    "\n   <property name=\"dataSource\" ref=\"WORKFLOW\" />" +
    "\n  </bean>";
}
