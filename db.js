const { Pool } = require('pg');
require('dotenv').config();

const { PGHOST, PGDATABASE, PGUSER, PGPASSWORD, DATABASE_USE_SSL } = process.env;

// Use SSL based on environment variable
const useSSL = DATABASE_USE_SSL === 'true';

const poolConfig = {
  host: Localhost,
  database: SwiftCart,
  user: PGUSER,
  password: PGPASSWORD,
  port: 5432,
};

// Configure SSL 
if (useSSL) {
  poolConfig.ssl = {
    require: true,
    rejectUnauthorized: false, 
  };
}

const pool = new Pool(poolConfig);

module.exports = {
  query: (text, params) => pool.query(text, params),
  connect: () => pool.connect(),
  end: () => pool.end(),
};