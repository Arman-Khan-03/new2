// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract EmployeeRecords {
    struct Employee {
        string name;
        string addressDetails;
        string phoneNumber;
        string parentNames;
        string qualification;
    }

    // Mapping from employee ID to their details
    mapping(uint256 => Employee) private employees;

    // Mapping to check if an employee exists
    mapping(uint256 => bool) private employeeExists;

    // Counter for employee IDs
    uint256 private employeeCounter;

    // Events
    event EmployeeAdded(uint256 employeeId, string name);
    event EmployeeUpdated(uint256 employeeId, string name);

    function addEmployee(
        string calldata _name,
        string calldata _addressDetails,
        string calldata _phoneNumber,
        string calldata _parentNames,
        string calldata _qualification
    ) external {
        uint256 employeeId = employeeCounter++;
        employees[employeeId] = Employee({
            name: _name,
            addressDetails: _addressDetails,
            phoneNumber: _phoneNumber,
            parentNames: _parentNames,
            qualification: _qualification
        });
        employeeExists[employeeId] = true;
        emit EmployeeAdded(employeeId, _name);
    }

    function updateEmployee(
        uint256 _employeeId,
        string calldata _name,
        string calldata _addressDetails,
        string calldata _phoneNumber,
        string calldata _parentNames,
        string calldata _qualification
    ) external {
        require(employeeExists[_employeeId], "Employee does not exist");

        employees[_employeeId] = Employee({
            name: _name,
            addressDetails: _addressDetails,
            phoneNumber: _phoneNumber,
            parentNames: _parentNames,
            qualification: _qualification
        });
        emit EmployeeUpdated(_employeeId, _name);
    }

    function getEmployee(uint256 _employeeId) external view returns (
        string memory name,
        string memory addressDetails,
        string memory phoneNumber,
        string memory parentNames,
        string memory qualification
    ) {
        require(employeeExists[_employeeId], "Employee does not exist");

        Employee storage emp = employees[_employeeId];
        return (
            emp.name,
            emp.addressDetails,
            emp.phoneNumber,
            emp.parentNames,
            emp.qualification
        );
    }
}
