contract PoE_Abstract {
    address owner;
    uint latestDocument;


	// Lista de escribanos
    mapping (address => bool) Notary;
    
    mapping(uint => DocumentTransfer) public history;
    mapping(bytes32 => bool) public usedHashes;
    mapping(bytes32 => address) public documentHashMap;

    struct DocumentTransfer {
        uint blockNumber;
        bytes32 hash;
        address from;
        address to;
    }
    event DocumentEvent(uint blockNumber, bytes32 indexed hash, address indexed from, address indexed to);
    modifier onlybyOwner();
    modifier onlybyNotary();
    modifier onlybyFileOwner();


    constructor();
    //Agregar un escribano a la lista, solo puede ser llamada por el owner del contrato
    function addNotary(address _escribano) public onlybyOwner();
    // Funcion llamada solo por los escibanos, crea el documento y lo transfiere al address que va a ser el dueño.
    // Un escribano tiene que apelar a otro escribano para adjudicarse a si mismo un archivo
    // es requisito checkear si el archivo ya existe y en caso de que exista, no volver a crearlo
	function newDocument(bytes32 hash, address _newFileOwner) public onlybyNotary() returns (bool success) ;

	// Funcion que devuelve "true" en caso de que el archivo ya exista.
    function documentExists(bytes32 hash) view returns (bool exists);
    
    //Funcion interna que registra lo sucedido cuando se crea o se transfiere un documento.
    function createHistory (bytes32 hash, address from, address to) internal;
    // funcion que transfiere la propiedad (el ser dueño) de un archivo, solo puede ser llamada por el propietario
    function transferDocument(bytes32 hash, address recipient) onlybyFileOwner() returns (bool success);

    function getDocument(uint docId) constant returns (uint blockNumber, bytes32 hash, address from, address to);
    function getLatest() constant returns (uint latest);
}