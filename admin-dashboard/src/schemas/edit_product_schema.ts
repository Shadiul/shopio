import * as yup from "yup";

export const EDIT_PRODUCT_SCHEMA = yup
  .object({
    name: yup.string().required("Name is required"),
    description: yup.string().required("Description is required"),
    price: yup.number().min(0).required("Price is required"),
    discount: yup.number().min(0).max(100).optional(),
    stock_quantity: yup.number().min(0).required("Stock Quantity is required"),
    tags: yup.string().optional(),
    unit: yup.string().required("Unit is required"),
  })
  .required();
