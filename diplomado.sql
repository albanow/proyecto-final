--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.1
-- Dumped by pg_dump version 9.4.0
-- Started on 2016-01-22 20:35:38

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 180 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 180
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 194 (class 1255 OID 1043887)
-- Name: actualizacliente(numeric, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION actualizacliente(pclave numeric, pnombre character varying, pappat character varying, papmat character varying, pfecnac character varying, pemail character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
Begin
  Update Clientes
     Set Nombre = Pnombre,
         Appat  = Pappat,
         Apmat  = Papmat,
         Fecnac = To_Date(Pfecnac, 'dd/mm/yyyy'),
         Email  = Pemail
   Where Idcliente = Pclave;

End;
$$;


ALTER FUNCTION public.actualizacliente(pclave numeric, pnombre character varying, pappat character varying, papmat character varying, pfecnac character varying, pemail character varying) OWNER TO postgres;

--
-- TOC entry 196 (class 1255 OID 1043885)
-- Name: borracliente(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION borracliente("pClave" numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	Delete from Clientes Where Idcliente = "pClave";
END;
$$;


ALTER FUNCTION public.borracliente("pClave" numeric) OWNER TO postgres;

--
-- TOC entry 193 (class 1255 OID 1043876)
-- Name: inserta_cliente_test(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION inserta_cliente_test() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	 Insert Into clientes(idcliente,nombre,appat,apmat,fecnac,email)
     Values(20,'RAUL','MACIAS','MANCILLA',TO_DATE('30/01/1978','dd/mm/yyyy'),'rmacias@mail.com');
END;
$$;


ALTER FUNCTION public.inserta_cliente_test() OWNER TO postgres;

--
-- TOC entry 195 (class 1255 OID 1043889)
-- Name: insertacliente(numeric, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION insertacliente(pclave numeric, pnombre character varying, pappat character varying, papmat character varying, pfecnac character varying, pemail character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
Begin
  Insert Into Clientes
    (Idcliente, Nombre, Appat, Apmat, Fecnac, Email)
  Values
    (Pclave,
     Pnombre,
     Pappat,
     Papmat,
     To_Date(Pfecnac, 'dd/mm/yyyy'),
     Pemail);

End;
$$;


ALTER FUNCTION public.insertacliente(pclave numeric, pnombre character varying, pappat character varying, papmat character varying, pfecnac character varying, pemail character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 179 (class 1259 OID 1043877)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE clientes (
    idcliente numeric NOT NULL,
    nombre character varying(30),
    appat character varying(30),
    apmat character varying(30),
    fecnac date,
    email character varying(250)
);


ALTER TABLE clientes OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 1043764)
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE countries (
    country_id character(2) NOT NULL,
    country_name character varying(40),
    region_id numeric,
    CONSTRAINT country_id_nn CHECK ((country_id IS NOT NULL))
);


ALTER TABLE countries OWNER TO postgres;

--
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE countries; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE countries IS 'country table. Contains 25 rows. References with locations table.';


--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN countries.country_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN countries.country_id IS 'Primary key of countries table.';


--
-- TOC entry 2095 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN countries.country_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN countries.country_name IS 'Country name';


--
-- TOC entry 2096 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN countries.region_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN countries.region_id IS 'Region ID for the country. Foreign key to region_id column in the departments table.';


--
-- TOC entry 175 (class 1259 OID 1043784)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE departments (
    department_id numeric(4,0) NOT NULL,
    department_name character varying(30),
    manager_id numeric(6,0),
    location_id numeric(4,0),
    CONSTRAINT dept_name_nn CHECK ((department_name IS NOT NULL))
);


ALTER TABLE departments OWNER TO postgres;

--
-- TOC entry 2097 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE departments; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE departments IS 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.';


--
-- TOC entry 2098 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN departments.department_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN departments.department_id IS 'Primary key column of departments table.';


--
-- TOC entry 2099 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN departments.department_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN departments.department_name IS 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. ';


--
-- TOC entry 2100 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN departments.manager_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN departments.manager_id IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';


--
-- TOC entry 2101 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN departments.location_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN departments.location_id IS 'Location id where a department is located. Foreign key to location_id column of locations table.';


--
-- TOC entry 176 (class 1259 OID 1043787)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE employees (
    employee_id numeric(6,0) NOT NULL,
    first_name character varying(20),
    last_name character varying(25),
    email character varying(25),
    phone_numeric character varying(20),
    hire_date date,
    job_id character varying(10),
    salary numeric(8,2),
    commission_pct numeric(2,2),
    manager_id numeric(6,0),
    department_id numeric(4,0),
    CONSTRAINT emp_email_nn CHECK ((email IS NOT NULL)),
    CONSTRAINT emp_hire_date_nn CHECK ((hire_date IS NOT NULL)),
    CONSTRAINT emp_job_nn CHECK ((job_id IS NOT NULL)),
    CONSTRAINT emp_last_name_nn CHECK ((last_name IS NOT NULL)),
    CONSTRAINT emp_salary_min CHECK ((salary > (0)::numeric))
);


ALTER TABLE employees OWNER TO postgres;

--
-- TOC entry 2102 (class 0 OID 0)
-- Dependencies: 176
-- Name: TABLE employees; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE employees IS 'employees table. Contains 107 rows. References with departments,
jobs, job_history tables. Contains a self reference.';


--
-- TOC entry 2103 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.employee_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.employee_id IS 'Primary key of employees table.';


--
-- TOC entry 2104 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.first_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.first_name IS 'First name of the employee. A not null column.';


--
-- TOC entry 2105 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.last_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.last_name IS 'Last name of the employee. A not null column.';


--
-- TOC entry 2106 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.email IS 'Email id of the employee';


--
-- TOC entry 2107 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.phone_numeric; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.phone_numeric IS 'Phone NUMERIC of the employee; includes country code and area code';


--
-- TOC entry 2108 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.hire_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.hire_date IS 'Date when the employee started on this job. A not null column.';


--
-- TOC entry 2109 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.job_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.job_id IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.';


--
-- TOC entry 2110 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.salary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.salary IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)';


--
-- TOC entry 2111 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.commission_pct; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.commission_pct IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage';


--
-- TOC entry 2112 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.manager_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.manager_id IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';


--
-- TOC entry 2113 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN employees.department_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN employees.department_id IS 'Department id where employee works; foreign key to department_id
column of the departments table';


--
-- TOC entry 178 (class 1259 OID 1043804)
-- Name: job_history; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE job_history (
    employee_id numeric(6,0) NOT NULL,
    start_date date NOT NULL,
    end_date date,
    job_id character varying(10),
    department_id numeric(4,0),
    CONSTRAINT jhist_date_interval CHECK ((end_date > start_date)),
    CONSTRAINT jhist_employee_nn CHECK ((employee_id IS NOT NULL)),
    CONSTRAINT jhist_end_date_nn CHECK ((end_date IS NOT NULL)),
    CONSTRAINT jhist_job_nn CHECK ((job_id IS NOT NULL)),
    CONSTRAINT jhist_start_date_nn CHECK ((start_date IS NOT NULL))
);


ALTER TABLE job_history OWNER TO postgres;

--
-- TOC entry 2114 (class 0 OID 0)
-- Dependencies: 178
-- Name: TABLE job_history; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE job_history IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';


--
-- TOC entry 2115 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN job_history.employee_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN job_history.employee_id IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';


--
-- TOC entry 2116 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN job_history.start_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN job_history.start_date IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';


--
-- TOC entry 2117 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN job_history.end_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN job_history.end_date IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';


--
-- TOC entry 2118 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN job_history.job_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN job_history.job_id IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';


--
-- TOC entry 2119 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN job_history.department_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN job_history.department_id IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';


--
-- TOC entry 174 (class 1259 OID 1043778)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jobs (
    job_id character varying(10) NOT NULL,
    job_title character varying(35),
    min_salary numeric(6,0),
    max_salary numeric(6,0),
    CONSTRAINT job_title_nn CHECK ((job_title IS NOT NULL))
);


ALTER TABLE jobs OWNER TO postgres;

--
-- TOC entry 2120 (class 0 OID 0)
-- Dependencies: 174
-- Name: TABLE jobs; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE jobs IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';


--
-- TOC entry 2121 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN jobs.job_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN jobs.job_id IS 'Primary key of jobs table.';


--
-- TOC entry 2122 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN jobs.job_title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN jobs.job_title IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';


--
-- TOC entry 2123 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN jobs.min_salary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN jobs.min_salary IS 'Minimum salary for a job title.';


--
-- TOC entry 2124 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN jobs.max_salary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN jobs.max_salary IS 'Maximum salary for a job title';


--
-- TOC entry 177 (class 1259 OID 1043790)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE locations (
    location_id numeric(4,0) NOT NULL,
    street_address character varying(40),
    postal_code character varying(12),
    city character varying(30),
    state_province character varying(25),
    country_id character(2),
    CONSTRAINT loc_city_nn CHECK ((city IS NOT NULL))
);


ALTER TABLE locations OWNER TO postgres;

--
-- TOC entry 2125 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE locations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE locations IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';


--
-- TOC entry 2126 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN locations.location_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN locations.location_id IS 'Primary key of locations table';


--
-- TOC entry 2127 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN locations.street_address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN locations.street_address IS 'Street address of an office, warehouse, or production site of a company.
Contains building NUMERIC and street name';


--
-- TOC entry 2128 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN locations.postal_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN locations.postal_code IS 'Postal code of the location of an office, warehouse, or production site
of a company. ';


--
-- TOC entry 2129 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN locations.city; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN locations.city IS 'A not null column that shows city where an office, warehouse, or
production site of a company is located. ';


--
-- TOC entry 2130 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN locations.state_province; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN locations.state_province IS 'State or Province where an office, warehouse, or production site of a
company is located.';


--
-- TOC entry 2131 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN locations.country_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN locations.country_id IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';


--
-- TOC entry 172 (class 1259 OID 1043755)
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE regions (
    region_id numeric NOT NULL,
    region_name character varying(25),
    CONSTRAINT region_id_nn CHECK ((region_id IS NOT NULL))
);


ALTER TABLE regions OWNER TO postgres;

--
-- TOC entry 2084 (class 0 OID 1043877)
-- Dependencies: 179
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO clientes (idcliente, nombre, appat, apmat, fecnac, email) VALUES (1, 'FRANCISCO', 'RAMIREZ', 'ORTEGA', '1975-06-02', 'fortega@mail.com');
INSERT INTO clientes (idcliente, nombre, appat, apmat, fecnac, email) VALUES (2, 'RAMIRO', 'GONZALEZ', 'RUIZ', '1974-01-30', 'rgonzalez@mail.com');
INSERT INTO clientes (idcliente, nombre, appat, apmat, fecnac, email) VALUES (3, 'RAUL', 'PEREZ', 'SERAS', '1978-11-15', 'rperez@mail.com');
INSERT INTO clientes (idcliente, nombre, appat, apmat, fecnac, email) VALUES (4, 'JAIME', 'VILLEGAS', 'RAMOS', '1965-01-01', 'jvillegas@mail.com');
INSERT INTO clientes (idcliente, nombre, appat, apmat, fecnac, email) VALUES (5, 'ANTONIO', 'PEREZ', 'SANTOYO', '1980-12-12', 'aperez@mail.com');
INSERT INTO clientes (idcliente, nombre, appat, apmat, fecnac, email) VALUES (6, 'PABLO', 'GARCIA', 'GUTIERREZ', '1980-12-12', 'pgarcia@mail.com');
INSERT INTO clientes (idcliente, nombre, appat, apmat, fecnac, email) VALUES (7, 'RODRIGO', 'LOPEZ', 'TIENDA', '1960-04-15', 'rlopez@mail.com');
INSERT INTO clientes (idcliente, nombre, appat, apmat, fecnac, email) VALUES (8, 'ALEJANDRO', 'ESPINOSA', 'LORENZANA', '1971-03-23', 'aespinosa@mail.com');
INSERT INTO clientes (idcliente, nombre, appat, apmat, fecnac, email) VALUES (9, 'SILVIA', 'ESQUIVEL', 'MONROY', '1977-09-27', 'sesquivel@mail.com');
INSERT INTO clientes (idcliente, nombre, appat, apmat, fecnac, email) VALUES (10, 'LAURA', 'PEREZ', 'LOPEZ', '1987-10-20', 'lperez@mail.com');


--
-- TOC entry 2078 (class 0 OID 1043764)
-- Dependencies: 173
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO countries (country_id, country_name, region_id) VALUES ('AR', 'Argentina', 2);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('AU', 'Australia', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('BE', 'Belgium', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('BR', 'Brazil', 2);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('CA', 'Canada', 2);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('CH', 'Switzerland', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('CN', 'China', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('DE', 'Germany', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('DK', 'Denmark', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('EG', 'Egypt', 4);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('FR', 'France', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('IL', 'Israel', 4);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('IN', 'India', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('IT', 'Italy', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('JP', 'Japan', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('KW', 'Kuwait', 4);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('ML', 'Malaysia', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('MX', 'Mexico', 2);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('NG', 'Nigeria', 4);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('NL', 'Netherlands', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('SG', 'Singapore', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('UK', 'United Kingdom', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('US', 'United States of America', 2);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('ZM', 'Zambia', 4);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('ZW', 'Zimbabwe', 4);


--
-- TOC entry 2080 (class 0 OID 1043784)
-- Dependencies: 175
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (10, 'Administration', 200, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (20, 'Marketing', 201, 1800);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (30, 'Purchasing', 114, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (40, 'Human Resources', 203, 2400);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (50, 'Shipping', 121, 1500);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (60, 'IT', 103, 1400);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (70, 'Public Relations', 204, 2700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (80, 'Sales', 145, 2500);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (90, 'Executive', 100, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (100, 'Finance', 108, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (110, 'Accounting', 205, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (120, 'Treasury', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (130, 'Corporate Tax', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (140, 'Control And Credit', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (150, 'Shareholder Services', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (160, 'Benefits', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (170, 'Manufacturing', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (180, 'Construction', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (190, 'Contracting', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (200, 'Operations', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (210, 'IT Support', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (220, 'NOC', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (230, 'IT Helpdesk', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (240, 'Government Sales', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (250, 'Retail Sales', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (260, 'Recruiting', NULL, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (270, 'Payroll', NULL, 1700);


--
-- TOC entry 2081 (class 0 OID 1043787)
-- Dependencies: 176
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (198, 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', '2007-06-21', 'SH_CLERK', 2600.00, NULL, 124, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (199, 'Douglas', 'Grant', 'DGRANT', '650.507.9844', '2008-01-13', 'SH_CLERK', 2600.00, NULL, 124, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', '2003-09-17', 'AD_ASST', 4400.00, NULL, 101, 10);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', '2004-02-17', 'MK_MAN', 13000.00, NULL, 100, 20);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (202, 'Pat', 'Fay', 'PFAY', '603.123.6666', '2005-08-17', 'MK_REP', 6000.00, NULL, 201, 20);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', '2002-06-07', 'HR_REP', 6500.00, NULL, 101, 40);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', '2002-06-07', 'PR_REP', 10000.00, NULL, 101, 70);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', '2002-06-07', 'AC_MGR', 12008.00, NULL, 101, 110);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', '2002-06-07', 'AC_ACCOUNT', 8300.00, NULL, 205, 110);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000.00, NULL, NULL, 90);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000.00, NULL, 100, 90);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000.00, NULL, 102, 60);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000.00, NULL, 103, 60);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800.00, NULL, 103, 60);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800.00, NULL, 103, 60);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200.00, NULL, 103, 60);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '2002-08-17', 'FI_MGR', 12008.00, NULL, 101, 100);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000.00, NULL, 108, 100);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (110, 'John', 'Chen', 'JCHEN', '515.124.4269', '2005-09-28', 'FI_ACCOUNT', 8200.00, NULL, 108, 100);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '2005-09-30', 'FI_ACCOUNT', 7700.00, NULL, 108, 100);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', '2006-03-07', 'FI_ACCOUNT', 7800.00, NULL, 108, 100);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', '2007-12-07', 'FI_ACCOUNT', 6900.00, NULL, 108, 100);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '2002-12-07', 'PU_MAN', 11000.00, NULL, 100, 30);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', '2003-05-18', 'PU_CLERK', 3100.00, NULL, 114, 30);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', '2005-12-24', 'PU_CLERK', 2900.00, NULL, 114, 30);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', '2005-07-24', 'PU_CLERK', 2800.00, NULL, 114, 30);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', '2006-11-15', 'PU_CLERK', 2600.00, NULL, 114, 30);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', '2007-08-10', 'PU_CLERK', 2500.00, NULL, 114, 30);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', '2004-07-18', 'ST_MAN', 8000.00, NULL, 100, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', '2005-04-10', 'ST_MAN', 8200.00, NULL, 100, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', '2003-05-01', 'ST_MAN', 7900.00, NULL, 100, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', '2005-10-10', 'ST_MAN', 6500.00, NULL, 100, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', '2007-11-16', 'ST_MAN', 5800.00, NULL, 100, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', '2005-07-16', 'ST_CLERK', 3200.00, NULL, 120, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', '2006-09-28', 'ST_CLERK', 2700.00, NULL, 120, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (127, 'James', 'Landry', 'JLANDRY', '650.124.1334', '2007-01-14', 'ST_CLERK', 2400.00, NULL, 120, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434', '2008-03-08', 'ST_CLERK', 2200.00, NULL, 120, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', '2005-08-20', 'ST_CLERK', 3300.00, NULL, 121, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', '2005-10-30', 'ST_CLERK', 2800.00, NULL, 121, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (131, 'James', 'Marlow', 'JAMRLOW', '650.124.7234', '2005-02-16', 'ST_CLERK', 2500.00, NULL, 121, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (132, 'TJ', 'Olson', 'TJOLSON', '650.124.8234', '2007-04-10', 'ST_CLERK', 2100.00, NULL, 121, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (133, 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', '2004-06-14', 'ST_CLERK', 3300.00, NULL, 122, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (134, 'Michael', 'Rogers', 'MROGERS', '650.127.1834', '2006-08-26', 'ST_CLERK', 2900.00, NULL, 122, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (135, 'Ki', 'Gee', 'KGEE', '650.127.1734', '2007-12-12', 'ST_CLERK', 2400.00, NULL, 122, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (136, 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', '2008-02-06', 'ST_CLERK', 2200.00, NULL, 122, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (137, 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', '2003-07-14', 'ST_CLERK', 3600.00, NULL, 123, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (138, 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', '2005-10-26', 'ST_CLERK', 3200.00, NULL, 123, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (139, 'John', 'Seo', 'JSEO', '650.121.2019', '2006-02-12', 'ST_CLERK', 2700.00, NULL, 123, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (140, 'Joshua', 'Patel', 'JPATEL', '650.121.1834', '2006-04-06', 'ST_CLERK', 2500.00, NULL, 123, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', '2003-10-17', 'ST_CLERK', 3500.00, NULL, 124, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', '2005-01-29', 'ST_CLERK', 3100.00, NULL, 124, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', '2006-03-15', 'ST_CLERK', 2600.00, NULL, 124, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', '2006-07-09', 'ST_CLERK', 2500.00, NULL, 124, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', '2004-10-01', 'SA_MAN', 14000.00, 0.40, 100, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', '2005-01-05', 'SA_MAN', 13500.00, 0.30, 100, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', '2005-03-10', 'SA_MAN', 12000.00, 0.30, 100, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', '2007-10-15', 'SA_MAN', 11000.00, 0.30, 100, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '2008-01-29', 'SA_MAN', 10500.00, 0.20, 100, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', '2005-01-30', 'SA_REP', 10000.00, 0.30, 145, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', '2005-03-24', 'SA_REP', 9500.00, 0.25, 145, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', '2005-08-20', 'SA_REP', 9000.00, 0.25, 145, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498718', '2006-03-30', 'SA_REP', 8000.00, 0.20, 145, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (154, 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', '2006-12-09', 'SA_REP', 7500.00, 0.20, 145, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', '2007-11-23', 'SA_REP', 7000.00, 0.15, 145, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (156, 'Janette', 'King', 'JKING', '011.44.1345.429268', '2004-01-30', 'SA_REP', 10000.00, 0.35, 146, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', '2004-03-04', 'SA_REP', 9500.00, 0.35, 146, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', '2004-08-01', 'SA_REP', 9000.00, 0.35, 146, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', '2005-03-10', 'SA_REP', 8000.00, 0.30, 146, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', '2005-12-15', 'SA_REP', 7500.00, 0.30, 146, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', '2006-11-03', 'SA_REP', 7000.00, 0.25, 146, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', '2005-11-11', 'SA_REP', 10500.00, 0.25, 147, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (163, 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', '2007-03-19', 'SA_REP', 9500.00, 0.15, 147, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (164, 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', '2008-01-24', 'SA_REP', 7200.00, 0.10, 147, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (165, 'David', 'Lee', 'DLEE', '011.44.1346.529268', '2008-02-23', 'SA_REP', 6800.00, 0.10, 147, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (166, 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', '2008-03-24', 'SA_REP', 6400.00, 0.10, 147, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (167, 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', '2008-04-21', 'SA_REP', 6200.00, 0.10, 147, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (168, 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', '2005-03-11', 'SA_REP', 11500.00, 0.25, 148, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (169, 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', '2006-03-23', 'SA_REP', 10000.00, 0.20, 148, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (170, 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', '2006-01-24', 'SA_REP', 9600.00, 0.20, 148, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (171, 'William', 'Smith', 'WSMITH', '011.44.1343.629268', '2007-02-23', 'SA_REP', 7400.00, 0.15, 148, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (172, 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', '2007-03-24', 'SA_REP', 7300.00, 0.15, 148, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (173, 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', '2008-04-21', 'SA_REP', 6100.00, 0.10, 148, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', '2004-05-11', 'SA_REP', 11000.00, 0.30, 149, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (175, 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', '2005-03-19', 'SA_REP', 8800.00, 0.25, 149, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', '2006-03-24', 'SA_REP', 8600.00, 0.20, 149, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (177, 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', '2006-04-23', 'SA_REP', 8400.00, 0.20, 149, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', '2007-05-24', 'SA_REP', 7000.00, 0.15, 149, NULL);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (179, 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', '2008-01-04', 'SA_REP', 6200.00, 0.10, 149, 80);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (180, 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', '2006-01-24', 'SH_CLERK', 3200.00, NULL, 120, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (181, 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', '2006-02-23', 'SH_CLERK', 3100.00, NULL, 120, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (182, 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', '2007-06-21', 'SH_CLERK', 2500.00, NULL, 120, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (183, 'Girard', 'Geoni', 'GGEONI', '650.507.9879', '2008-02-03', 'SH_CLERK', 2800.00, NULL, 120, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (184, 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', '2004-01-27', 'SH_CLERK', 4200.00, NULL, 121, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (185, 'Alexis', 'Bull', 'ABULL', '650.509.2876', '2005-02-20', 'SH_CLERK', 4100.00, NULL, 121, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (186, 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', '2006-06-24', 'SH_CLERK', 3400.00, NULL, 121, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (187, 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', '2007-02-07', 'SH_CLERK', 3000.00, NULL, 121, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (188, 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', '2005-06-14', 'SH_CLERK', 3800.00, NULL, 122, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (189, 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', '2005-08-13', 'SH_CLERK', 3600.00, NULL, 122, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (190, 'Timothy', 'Gates', 'TGATES', '650.505.3876', '2006-07-11', 'SH_CLERK', 2900.00, NULL, 122, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (191, 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', '2007-12-19', 'SH_CLERK', 2500.00, NULL, 122, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (192, 'Sarah', 'Bell', 'SBELL', '650.501.1876', '2004-02-04', 'SH_CLERK', 4000.00, NULL, 123, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (193, 'Britney', 'Everett', 'BEVERETT', '650.501.2876', '2005-03-03', 'SH_CLERK', 3900.00, NULL, 123, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (194, 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', '2006-07-01', 'SH_CLERK', 3200.00, NULL, 123, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (195, 'Vance', 'Jones', 'VJONES', '650.501.4876', '2007-03-17', 'SH_CLERK', 2800.00, NULL, 123, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (196, 'Alana', 'Walsh', 'AWALSH', '650.507.9811', '2006-04-24', 'SH_CLERK', 3100.00, NULL, 124, 50);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_numeric, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (197, 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', '2006-05-23', 'SH_CLERK', 3000.00, NULL, 124, 50);


--
-- TOC entry 2083 (class 0 OID 1043804)
-- Dependencies: 178
-- Data for Name: job_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (102, '2001-01-13', '2006-07-24', 'IT_PROG', 60);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '1997-09-21', '2001-10-27', 'AC_ACCOUNT', 110);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '2001-10-28', '2005-03-15', 'AC_MGR', 110);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (201, '2004-02-17', '2007-12-19', 'MK_REP', 20);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (114, '2006-03-24', '2007-12-31', 'ST_CLERK', 50);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (122, '2007-01-01', '2007-12-31', 'ST_CLERK', 50);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (200, '1995-09-17', '2001-06-17', 'AD_ASST', 90);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (176, '2006-03-24', '2006-12-31', 'SA_REP', 80);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (176, '2007-01-01', '2007-12-31', 'SA_MAN', 80);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (200, '2002-07-01', '2006-12-31', 'AC_ACCOUNT', 90);


--
-- TOC entry 2079 (class 0 OID 1043778)
-- Dependencies: 174
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('AD_PRES', 'President', 20080, 40000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('AD_VP', 'Administration Vice President', 15000, 30000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('AD_ASST', 'Administration Assistant', 3000, 6000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('FI_MGR', 'Finance Manager', 8200, 16000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('FI_ACCOUNT', 'Accountant', 4200, 9000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('AC_MGR', 'Accounting Manager', 8200, 16000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('SA_MAN', 'Sales Manager', 10000, 20080);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('SA_REP', 'Sales Representative', 6000, 12008);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('PU_MAN', 'Purchasing Manager', 8000, 15000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('PU_CLERK', 'Purchasing Clerk', 2500, 5500);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('ST_MAN', 'Stock Manager', 5500, 8500);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('ST_CLERK', 'Stock Clerk', 2008, 5000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('SH_CLERK', 'Shipping Clerk', 2500, 5500);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('IT_PROG', 'Programmer', 4000, 10000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('MK_MAN', 'Marketing Manager', 9000, 15000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('MK_REP', 'Marketing Representative', 4000, 9000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('HR_REP', 'Human Resources Representative', 4000, 9000);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES ('PR_REP', 'Public Relations Representative', 4500, 10500);


--
-- TOC entry 2082 (class 0 OID 1043790)
-- Dependencies: 177
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2400, '8204 Arthur St', NULL, 'London', NULL, 'UK');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX');


--
-- TOC entry 2077 (class 0 OID 1043755)
-- Dependencies: 172
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO regions (region_id, region_name) VALUES (1, 'Europe');
INSERT INTO regions (region_id, region_name) VALUES (2, 'Americas');
INSERT INTO regions (region_id, region_name) VALUES (3, 'Asia');
INSERT INTO regions (region_id, region_name) VALUES (4, 'Middle East and Africa');


--
-- TOC entry 1932 (class 2606 OID 1043771)
-- Name: country_c_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT country_c_id_pk PRIMARY KEY (country_id);


--
-- TOC entry 1936 (class 2606 OID 1043808)
-- Name: dept_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT dept_id_pk PRIMARY KEY (department_id);


--
-- TOC entry 1940 (class 2606 OID 1043839)
-- Name: emp_email_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT emp_email_uk UNIQUE (email);


--
-- TOC entry 1942 (class 2606 OID 1043837)
-- Name: emp_emp_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT emp_emp_id_pk PRIMARY KEY (employee_id);


--
-- TOC entry 1953 (class 2606 OID 1043817)
-- Name: jhist_emp_id_st_date_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY job_history
    ADD CONSTRAINT jhist_emp_id_st_date_pk PRIMARY KEY (employee_id, start_date);


--
-- TOC entry 1934 (class 2606 OID 1043782)
-- Name: job_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT job_id_pk PRIMARY KEY (job_id);


--
-- TOC entry 1949 (class 2606 OID 1043794)
-- Name: loc_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT loc_id_pk PRIMARY KEY (location_id);


--
-- TOC entry 1957 (class 2606 OID 1043884)
-- Name: pk$clientes$idcliente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT "pk$clientes$idcliente" PRIMARY KEY (idcliente);


--
-- TOC entry 1930 (class 2606 OID 1043762)
-- Name: reg_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT reg_id_pk PRIMARY KEY (region_id);


--
-- TOC entry 1937 (class 1259 OID 1043815)
-- Name: dept_location_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX dept_location_ix ON departments USING btree (location_id);


--
-- TOC entry 1938 (class 1259 OID 1043860)
-- Name: emp_department_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX emp_department_ix ON employees USING btree (department_id);


--
-- TOC entry 1943 (class 1259 OID 1043861)
-- Name: emp_job_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX emp_job_ix ON employees USING btree (job_id);


--
-- TOC entry 1944 (class 1259 OID 1043862)
-- Name: emp_manager_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX emp_manager_ix ON employees USING btree (manager_id);


--
-- TOC entry 1945 (class 1259 OID 1043863)
-- Name: emp_name_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX emp_name_ix ON employees USING btree (last_name, first_name);


--
-- TOC entry 1951 (class 1259 OID 1043833)
-- Name: jhist_department_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX jhist_department_ix ON job_history USING btree (department_id);


--
-- TOC entry 1954 (class 1259 OID 1043834)
-- Name: jhist_employee_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX jhist_employee_ix ON job_history USING btree (employee_id);


--
-- TOC entry 1955 (class 1259 OID 1043835)
-- Name: jhist_job_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX jhist_job_ix ON job_history USING btree (job_id);


--
-- TOC entry 1946 (class 1259 OID 1043801)
-- Name: loc_city_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX loc_city_ix ON locations USING btree (city);


--
-- TOC entry 1947 (class 1259 OID 1043802)
-- Name: loc_country_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX loc_country_ix ON locations USING btree (country_id);


--
-- TOC entry 1950 (class 1259 OID 1043803)
-- Name: loc_state_province_ix; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX loc_state_province_ix ON locations USING btree (state_province);


--
-- TOC entry 1958 (class 2606 OID 1043772)
-- Name: countr_reg_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countr_reg_fk FOREIGN KEY (region_id) REFERENCES regions(region_id);


--
-- TOC entry 1959 (class 2606 OID 1043809)
-- Name: dept_loc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT dept_loc_fk FOREIGN KEY (location_id) REFERENCES locations(location_id);


--
-- TOC entry 1960 (class 2606 OID 1043864)
-- Name: dept_mgr_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT dept_mgr_fk FOREIGN KEY (manager_id) REFERENCES employees(employee_id);


--
-- TOC entry 1961 (class 2606 OID 1043840)
-- Name: emp_dept_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES departments(department_id);


--
-- TOC entry 1962 (class 2606 OID 1043845)
-- Name: emp_job_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT emp_job_fk FOREIGN KEY (job_id) REFERENCES jobs(job_id);


--
-- TOC entry 1963 (class 2606 OID 1043850)
-- Name: emp_manager_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT emp_manager_fk FOREIGN KEY (manager_id) REFERENCES employees(employee_id);


--
-- TOC entry 1965 (class 2606 OID 1043818)
-- Name: jhist_dept_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY job_history
    ADD CONSTRAINT jhist_dept_fk FOREIGN KEY (department_id) REFERENCES departments(department_id);


--
-- TOC entry 1967 (class 2606 OID 1043869)
-- Name: jhist_emp_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY job_history
    ADD CONSTRAINT jhist_emp_fk FOREIGN KEY (employee_id) REFERENCES employees(employee_id);


--
-- TOC entry 1966 (class 2606 OID 1043823)
-- Name: jhist_job_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY job_history
    ADD CONSTRAINT jhist_job_fk FOREIGN KEY (job_id) REFERENCES jobs(job_id);


--
-- TOC entry 1964 (class 2606 OID 1043795)
-- Name: loc_c_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT loc_c_id_fk FOREIGN KEY (country_id) REFERENCES countries(country_id);


--
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-01-22 20:35:39

--
-- PostgreSQL database dump complete
--
