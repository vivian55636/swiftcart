require('dotenv').config();
const { Sequelize, DataTypes, Model } = require('sequelize');

// Use SSL based on an environment variable and other logic
const useSSL = process.env.DATABASE_USE_SSL === 'true'; // Assuming an environment variable that flags SSL usage

const sequelizeOptions = {
  host: process.env.PGHOST,
  dialect: 'postgres',
};

// If SSL is required, configure dialect options for SSL
if (useSSL) {
  sequelizeOptions.dialectOptions = {
    ssl: {
      require: true,
      rejectUnauthorized: true, // Ensures that SSL is used and the certificate is verified
    },
  };
}

// Create a new Sequelize instance with environment variables
const sequelize = new Sequelize(process.env.PGDATABASE, process.env.PGUSER, process.env.PGPASSWORD, sequelizeOptions);

class User extends Model {}
User.init({
  user_id: { type: DataTypes.INTEGER, primaryKey: true },
  username: DataType.STRING,
  password: DataType.STRING,
  first_name: DataTypes.STRING,
  last_name: DataTypes.STRING,
  email: DataTypes.STRING,
  phone: DataTypes.STRING,
  address: DataTypes.STRING,
}, { sequelize, modelName: 'user', timestamps: false });

module.exports = { User };